require File.dirname(__FILE__) + '/spec_helper'

describe Watir::IE do

  it "closes the browser even when Watir::IE#run_error_checks throws an exception" do
    @browser.add_checker lambda {raise "let's fail IE#wait in IE#close"}
    @browser.should exist
    lambda {@browser.close}.should_not raise_exception
    @browser.should_not exist
  end

end