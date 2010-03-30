module Watir
  module PageCheckers
    JAVASCRIPT_ERRORS_CHECKER = lambda {|ie| raise "Got JavaScript error!" if ie.status =~ /Error on page/}
  end
end

# patches for Watir
module Watir
  class IE
    # This is Watir's overriden wait method, which is used in many places for deciding
    # if browser is ready or not. We have to patch one line in it to work properly
    # when file save as dialog has been displayed. For some reason READYSTATE (4)
    # property value will be READYSTATE_INTERACTIVE (3) after file has been downloaded
    # and not 4, thus wait will stay blocking.

    # read more about IE READYSTATE property:
    # http://msdn.microsoft.com/en-us/library/aa768362(VS.85).aspx
    def wait(no_sleep=false)
      @xml_parser_doc = nil
      @down_load_time = 0.0
      a_moment = 0.2 # seconds
      start_load_time = Time.now

      begin
        while @ie.busy # XXX need to add time out
          sleep a_moment
        end
        # this is the line which has been changed to accept also state 3
        until @ie.readyState <= READYSTATE_COMPLETE do
          sleep a_moment
        end
        sleep a_moment
        until @ie.document do
          sleep a_moment
        end

        documents_to_wait_for = [@ie.document]

      rescue WIN32OLERuntimeError # IE window must have been closed
        @down_load_time = Time.now - start_load_time
        sleep @pause_after_wait unless no_sleep
        return @down_load_time
      end

      while doc = documents_to_wait_for.shift
        begin
          until doc.readyState == "complete" do
            sleep a_moment
          end
          @url_list << doc.location.href unless @url_list.include?(doc.location.href)
          doc.frames.length.times do |n|
            begin
              documents_to_wait_for << doc.frames[n.to_s].document
            rescue WIN32OLERuntimeError, NoMethodError
            end
          end
        rescue WIN32OLERuntimeError
        end
      end

      @down_load_time = Time.now - start_load_time
      run_error_checks
      sleep @pause_after_wait unless no_sleep
      @down_load_time
    end
  end

  module PageContainer
    # patch for .click_no_wait
    def eval_in_spawned_process(command)
      command.strip!
      ruby_code = "require 'rubygems';"
      ruby_code << "require 'watir/ie';"
      ruby_code << "pc = #{attach_command};"
      ruby_code << "pc.instance_eval(#{command.inspect});"
      exec_string = "start rubyw -e #{ruby_code.inspect}".gsub("\\\"", "'")
      system(exec_string)
    end
  end
end