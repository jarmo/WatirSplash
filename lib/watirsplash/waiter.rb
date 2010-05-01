module WatirSplash
  module Waiter
    # waits until some condition is true and
    # throws Watir::Exception::TimeOutException upon timeout
    #
    # examples:
    #   wait_until! {text_field(:name => 'x').exists?} # waits until text field exists
    #   wait_until!(5) {...} # waits maximum of 5 seconds condition to be true
    def wait_until! *arg
      Watir::Waiter.wait_until(*arg) {yield}
    end

    # waits until some condition is true and
    # returns false if timeout occurred, true otherwise
    #
    # examples:
    #   wait_until {text_field(:name => 'x').exists?} # waits until text field exists
    #   wait_until(5) {...} # waits maximum of 5 seconds condition to be true
    def wait_until *arg
      begin
        wait_until!(*arg) {yield}
      rescue Watir::Exception::TimeOutException
        return false
      end

      return true
    end
  end
end