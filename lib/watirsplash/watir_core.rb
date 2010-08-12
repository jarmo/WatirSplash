# these require statements are needed for Watir
# to work with minimum functionality
#
# this is needed for #click_no_wait to perform faster
t = Time.now
module Watir
  # dummy modules for patching
  module Win32
  end

  module Utils
  end
end


require 'watir/win32ole'
require 'logger'
require 'watir/exceptions'
require 'watir/matches'

require 'watir/core_ext'
require 'watir/logger'
require 'watir/container'
require 'watir/locator'
require 'watir/page-container'
require 'watir/ie-class'
require 'watir/element'
require 'watir/element_collections'
require 'watir/form'
require 'watir/non_control_elements'
require 'watir/input_elements'
require 'watir/table'
require 'watir/image'
require 'watir/link'
begin
  require 'watir/html_element'
rescue LoadError
  # this exists currently only on github
end

require 'watir/waiter'

# watir/module
module Watir
  include Watir::Exception

# Directory containing the watir.rb file
  @@dir = File.expand_path(File.dirname(__FILE__))

  ATTACHER = Waiter.new
# Like regular Ruby "until", except that a TimeOutException is raised
# if the timeout is exceeded. Timeout is IE.attach_timeout.
  def self.until_with_timeout # block
    ATTACHER.timeout = IE.attach_timeout
    ATTACHER.wait_until { yield }
  end

  @@autoit = nil

  def self.autoit
    unless @@autoit
      begin
        @@autoit = WIN32OLE.new('AutoItX3.Control')
      rescue WIN32OLERuntimeError
        _register('AutoItX3.dll')
        @@autoit = WIN32OLE.new('AutoItX3.Control')
      end
    end
    @@autoit
  end

  def self._register(dll)
    system("regsvr32.exe /s "    + "#{@@dir}/#{dll}".gsub('/', '\\'))
  end

  def self._unregister(dll)
    system("regsvr32.exe /s /u " + "#{@@dir}/#{dll}".gsub('/', '\\'))
  end

end
puts Time.now - t