module AutoIt
  class Window
    include Watir::WaitHelper

    class << self
      def autoit
        @@autoit
      end
    end

    @@autoit = Watir.autoit
    attr_reader :locator

    def initialize(window_locator)
      @locator =
              case window_locator
                when Regexp
                  "[REGEXPTITLE:#{window_locator}]"
                when Fixnum
                  "[HANDLE:#{window_locator.to_s(16).rjust(8, "0")}]"
                else
                  window_locator
              end
      @title = window_locator
    end

    # makes window active
    # * returns true if activation was successful and false otherwise
    def activate
      @@autoit.WinWait(@locator, "", 1) == 1 &&
              @@autoit.WinActivate(@locator) != 0 &&
              @@autoit.WinActive(@locator) != 0
    end

    def text
      @@autoit.WinGetText(@locator)
    end

    def exists?
      @@autoit.WinExists(@locator) == 1
    end

    def close
      @@autoit.WinClose(@locator)
      @@autoit.WinKill(@locator)
    end

    def button(name)
      Button.new(self, name)
    end

    def text_field(name)
      TextField.new(self, name)
    end

    def method_missing name, *args #:nodoc:
      @@autoit.respond_to?(name) ? @@autoit.send(name, *args) : super
    end
  end

  class Button
    include Watir::WaitHelper

    def initialize(window, button_name)
      @window = window
      @name = button_name
    end

    # clicks specified button on window with specified title,
    # activates window automatically and makes sure that the click
    # was successful
    def click
      clicked = false
      wait_until do
        @window.activate &&
                Window.autoit.ControlFocus(@window.locator, "", @name) == 1 &&
                Window.autoit.ControlClick(@window.locator, "", @name) == 1 &&
                clicked = true # is clicked at least once

        clicked && !exists?
      end
    end

    def exists?
      not Window.autoit.ControlGetHandle(@window.locator, "", @name).empty?
    end
  end

  class TextField
    include Watir::WaitHelper

    def initialize(window, field_name)
      @window = window
      @name = field_name
    end

    # sets specified field's value on window with specified title,
    # activates window automatically and makes sure that the field's
    # value got changed
    def set(text)
      wait_until do
        @window.activate &&
                Window.autoit.ControlFocus(@window.locator, "", @name) == 1 &&
                Window.autoit.ControlSetText(@window.locator, "", @name, text) == 1 &&
                value == text
      end
    end

    def clear
      set ""
    end

    def value
      Window.autoit.ControlGetText(@window.locator, "", @name)
    end

    def exists?
      not Window.autoit.ControlGetHandle(@window.locator, "", @name).empty?
    end
  end
end