class AutoItHelper

  @@autoit = Watir.autoit

  class << self
    def click_save(window_title="File Download")
      click_button(window_title, "&Save")
    end

    def set_edit(field_value, window_title="Save As")
      set_field(window_title, "Edit1", field_value)
    end

    def set_field(window_title, field_name, field_value)
      wait_until! do
        activate_window(window_title) &&
                @@autoit.ControlFocus(window_title, "", field_name) == 1 &&
                @@autoit.ControlSetText(window_title, "", field_name, field_value) == 1 &&
                @@autoit.ControlGetText(window_title, "", field_name) == field_value
      end
    end

    def click_button(window_title, button_name)
      wait_until! do
        activate_window(window_title) &&
                @@autoit.ControlFocus(window_title, "", button_name) == 1 &&
                @@autoit.ControlClick(window_title, "", button_name) == 1 &&
                wait_until(3) {@@autoit.WinExists(window_title) == 0}
      end
    end

    def activate_window(window_title)
      @@autoit.WinWait(window_title, "", 1) == 1 &&
              @@autoit.WinActivate(window_title) != 0 &&
              @@autoit.WinActive(window_title) != 0
    end
  end
end