module AutoIt
  class Window
    include Watir::WaitHelper

    attr_reader :title, :autoit

    def initialize(window_title)
      @title = window_title
      @autoit = Watir.autoit
    end

    # makes window active
    # * returns true if activation was successful and false otherwise
    def activate
      @autoit.WinWait(@title, "", 1) == 1 &&
              @autoit.WinActivate(@title) != 0 &&
              @autoit.WinActive(@title) != 0
    end

    def exists?
      @autoit.WinExists(@title) == 1
    end

    def button(name)
      Button.new(self, name)
    end

    def save_button
      button("&Save")
    end

    def text_field(name)
      TextField.new(self, name)
    end

    def edit_text_field
      text_field("Edit1")
    end

    def method_missing name, *args #:nodoc:
      @autoit.respond_to?(name) ? @autoit.send(name, *args) : super
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
      wait_until do
        @window.activate &&
                @window.autoit.ControlFocus(@window.title, "", @name) == 1 &&
                @window.autoit.ControlClick(@window.title, "", @name) == 1 &&
                wait_until?(3) {not @window.exists?}
      end
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
                @window.autoit.ControlFocus(@window.title, "", @name) == 1 &&
                @window.autoit.ControlSetText(@window.title, "", @name, text) == 1 &&
                value == text
      end
    end

    def value
      @window.autoit.ControlGetText(@window.title, "", @name)
    end
  end
end