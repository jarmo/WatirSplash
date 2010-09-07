# encoding: utf-8

# This code is made by Jari Bakken @ https://gist.github.com/1b14247aae08a7e93f54
#
# Added wait_until? and wait_while? methods and reduced sleeping time to 0.1 secs
module Watir
  module WaitHelper
    extend self

    class TimeoutError < StandardError
    end

    #
    # Wait until the block evaluates to true or times out.
    #

    def wait_until(timeout = 60, &block)
      end_time = ::Time.now + timeout

      until ::Time.now > end_time
        result = yield(self)
        return result if result
        sleep 0.1
      end

      raise TimeoutError, "timed out after #{timeout} seconds"
    end

    def wait_until?(timeout = 60, &block)
      wait_until(timeout, &block)
      true
    rescue TimeoutError
      false
    end

    #
    # Wait while the block evaluates to true or times out.
    #

    def wait_while(timeout = 60, &block)
      end_time = ::Time.now + timeout

      until ::Time.now > end_time
        return unless yield(self)
        sleep 0.1
      end

      raise TimeoutError, "timed out after #{timeout} seconds"
    end

    def wait_while?(timeout = 60, &block)
      wait_until(timeout, &block)
      true
    rescue TimeoutError
      false
    end

  end # WaitHelper
end # Watir