describe "RSpec patches" do

  before :each do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/test.html"
  end

  context "RSpec::Matchers" do
    context "#within" do
      it "can be used with #change" do
        t = Time.now
        expect {
          link(:id => "toggle").click
        }.to change {div(:id => "div2").text}.from("Div is shown").to("Div is hidden").within(2)
        (Time.now - t).should be <= 2
      end

      it "will fail upon timeout" do
        t = Time.now
        expect {
          expect {
            link(:id => "toggle").click
          }.to change {div(:id => "div2").text}.from("Div is shown").to("Div is hidden").within(0.5)
        }.to raise_exception(%q{result should have been changed to "Div is hidden", but is now "Div is shown"})
        (Time.now - t).should be >= 0.5
      end

      it "can be used with #make" do
        t = Time.now
        expect {
          link(:id => "toggle").click
        }.to make {div(:id => "div1").present?}.within(2)
        (Time.now - t).should be <= 2
      end

      it "handles #should_not via matcher's #matches?" do
        t = Time.now
        h = {:special => true}
        Thread.new {sleep 0.5; h.delete :special}
        h.should_not have_key(:special).within(1)
        (Time.now - t).should be_between(0.5, 1)
      end

      it "fails when #should_not is not satisfied within timeout via matcher's #matches?" do
        t = Time.now
        h = {:special => true}
        expect {
          h.should_not have_key(:special).within(0.5)
        }.to raise_error
        (Time.now - t).should be >= 0.5
      end

      it "handles #should_not via matcher's #does_not_match?" do
        RSpec::Matchers.define :have_my_key do |expected|
          match_for_should_not do |actual|
            !actual.has_key?(expected)
          end
        end

        t = Time.now
        h = {:special => true}
        Thread.new {sleep 0.5; h.delete :special}
        h.should_not have_my_key(:special).within(1)
        (Time.now - t).should be_between(0.5, 1)
      end

      it "fails when #should_not is not satisfied within timeout via matcher's #does_not_match?" do
        RSpec::Matchers.define :have_my_key do |expected|
          match_for_should_not do |actual|
            !actual.has_key?(expected)
          end
        end

        t = Time.now
        h = {:special => true}
        expect {
          h.should_not have_my_key(:special).within(0.5)
        }.to raise_error
        (Time.now - t).should be >= 0.5
      end
    end

    context "#during" do
      it "will pass upon timeout" do
        require "ruby-debug"; debugger;
        t = Time.now
        true.should be_true.during(0.5)
        (Time.now - t).should be >= 0.5
      end

      it "handles #should_not via matcher's #matches?" do
        t = Time.now
        h = {}
        h.should_not have_key(:special).during(1)
        (Time.now - t).should be >= 1
      end

      it "fails when #should_not is not satisfied during timeout via matcher's #matches?" do
        t = Time.now
        h = {}
        Thread.new {sleep 0.5; h[:special] = true}
        expect {
          h.should_not have_key(:special).during(1)
        }.to raise_error
        (Time.now - t).should be_between(0.5, 1)
      end

      it "handles #should_not via matcher's #does_not_match?" do
        RSpec::Matchers.define :have_my_key do |expected|
          match_for_should_not do |actual|
            !actual.has_key?(expected)
          end
        end

        t = Time.now
        h = {}
        h.should_not have_my_key(:special).during(1)
        (Time.now - t).should be >= 1
      end

      it "fails when #should_not is not satisfied within timeout via matcher's #does_not_match?" do
        RSpec::Matchers.define :have_my_key do |expected|
          match_for_should_not do |actual|
            !actual.has_key?(expected)
          end
        end

        t = Time.now
        h = {}
        Thread.new {sleep 0.5; h[:special] = true}
        expect {
          h.should_not have_my_key(:special).during(1)
        }.to raise_error
        (Time.now - t).should be_between(0.5, 1)
      end
    end

    context "#soon" do
      it "is an alias for #in(30)" do
        t = Time.now
        expect {
          link(:id => "toggle").click
        }.to make {div(:id => "div1").present?}.soon
        (Time.now - t).should be <= 30
      end
    end

    context "#make" do
      it "is an alias for #change" do
        expect {
          text_field(:name => "field1").clear
        }.to make {text_field(:name => "field1").value.empty?}
      end
    end

    context "#seconds" do
      it "is for syntactic sugar" do
        RSpec::Matchers::Matcher.new(nil) {}.within(2).seconds.instance_variable_get(:@within_timeout).should == 2
        RSpec::Matchers::Matcher.new(nil) {}.during(3).seconds.instance_variable_get(:@during_timeout).should == 3
      end

      it "has #second as an alias" do
        RSpec::Matchers::Matcher.new(nil) {}.within(1).second.instance_variable_get(:@within_timeout).should == 1
        RSpec::Matchers::Matcher.new(nil) {}.during(2).second.instance_variable_get(:@during_timeout).should == 2
      end
    end

    context "#minutes" do
      it "converts timeout into minutes" do
        RSpec::Matchers::Matcher.new(nil) {}.within(2).minutes.instance_variable_get(:@within_timeout).should == 2*60
        RSpec::Matchers::Matcher.new(nil) {}.during(3).minutes.instance_variable_get(:@during_timeout).should == 3*60
      end

      it "has #minute as an alias" do
        RSpec::Matchers::Matcher.new(nil) {}.within(1).minute.instance_variable_get(:@within_timeout).should == 1*60
        RSpec::Matchers::Matcher.new(nil) {}.during(2).minute.instance_variable_get(:@during_timeout).should == 2*60
      end
    end

  end
end
