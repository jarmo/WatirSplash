module AutoIt
  class Window
    include Watir::WaitHelper

    class << self
      def autoit
        @@autoit
      end
    end

    @@autoit = Watir.autoit
    attr_reader :title

    def initialize(window_title)
      @title = window_title
    end

    # makes window active
    # * returns true if activation was successful and false otherwise
    def activate
      @@autoit.WinWait(@title, "", 1) == 1 &&
              @@autoit.WinActivate(@title) != 0 &&
              @@autoit.WinActive(@title) != 0
    end

    def exists?
      @@autoit.WinExists(@title) == 1
    end

    def close
      @@autoit.WinClose(@title)
      @@autoit.WinKill(@title)
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
                Window.autoit.ControlFocus(@window.title, "", @name) == 1 &&
                Window.autoit.ControlClick(@window.title, "", @name) == 1 &&
                clicked = true # is clicked at least once

        clicked && !exists?
      end
    end

    def exists?
      not Window.autoit.ControlGetHandle(@window.title, "", @name).empty?
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
                Window.autoit.ControlFocus(@window.title, "", @name) == 1 &&
                Window.autoit.ControlSetText(@window.title, "", @name, text) == 1 &&
                value == text
      end
    end

    def value
      Window.autoit.ControlGetText(@window.title, "", @name)
    end

    def exists?
      not Window.autoit.ControlGetHandle(@window.title, "", @name).empty?
    end
  end
end