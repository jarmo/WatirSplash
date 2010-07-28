module WatirSplash
# Helper class for AutoIt
  class AutoItHelper
    extend WatirSplash::Waiter

    @@autoit = Watir.autoit

    class << self
      # clicks save button on window with specified title,
      # activates window automatically and makes sure that the click
      # was successful
      def click_save(window_title="File Download")
        click_button(window_title, "&Save")
      end

      # sets edit field value to field_value on window with specified title,
      # activates window automatically and makes sure that the field's
      # value got changed
      def set_edit(field_value, window_title="Save As")
        set_field(window_title, "Edit1", field_value)
      end

      # sets specified field's value on window with specified title,
      # activates window automatically and makes sure that the field's
      # value got changed
      def set_field(window_title, field_name, field_value)
        wait_until do
          activate_window(window_title) &&
                  @@autoit.ControlFocus(window_title, "", field_name) == 1 &&
                  @@autoit.ControlSetText(window_title, "", field_name, field_value) == 1 &&
                  @@autoit.ControlGetText(window_title, "", field_name) == field_value
        end
      end

      # clicks specified button on window with specified title,
      # activates window automatically and makes sure that the click
      # was successful
      def click_button(window_title, button_name)
        wait_until do
          activate_window(window_title) &&
                  @@autoit.ControlFocus(window_title, "", button_name) == 1 &&
                  @@autoit.ControlClick(window_title, "", button_name) == 1 &&
                  wait_until?(3) {@@autoit.WinExists(window_title) == 0}
        end
      end

      # makes window active with specified title
      # * returns true if activation was successful and false otherwise
      def activate_window(window_title)
        @@autoit.WinWait(window_title, "", 1) == 1 &&
                @@autoit.WinActivate(window_title) != 0 &&
                @@autoit.WinActive(window_title) != 0
      end
    end
  end
end