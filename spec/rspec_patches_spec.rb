describe "RSpec patches" do

  before :each do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/test.html"
  end

  context "RSpec::Matchers" do
    context "#in" do
      it "can be used with #change" do
        expect {
          link(:id => "toggle").click
        }.to change {div(:id => "div2").text}.from("Div is shown").to("Div is hidden").in(2)
      end

      it "will fail upon timeout" do
        expect {
          expect {
            link(:id => "toggle").click
          }.to change {div(:id => "div2").text}.from("Div is shown").to("Div is hidden").in(0.1)
        }.to raise_exception(%q{result should have been changed to "Div is hidden", but is now "Div is shown"})
      end

      it "can be used with #make" do
        expect {
          link(:id => "toggle").click
        }.to make {div(:id => "div1").present?}.in(2)
      end

      it "handles #should_not via matcher's #matches?" do
        h = {:special => true}
        Thread.new {sleep 0.5; h.delete :special}
        h.should_not have_key(:special).in(1)
      end

      it "fails when #should_not is not satisfied within timeout via matcher's #matches?" do
        h = {:special => true}
        expect {
          h.should_not have_key(:special).in(0.1)
        }.to raise_error
      end

      it "handles #should_not via matcher's #does_not_match?" do
        RSpec::Matchers.define :have_my_key do |expected|
          match_for_should_not do |actual|
            !actual.has_key?(expected)
          end
        end

        h = {:special => true}
        Thread.new {sleep 0.5; h.delete :special}
        h.should_not have_my_key(:special).in(1)
      end
      
      it "fails when #should_not is not satisfied within timeout via matcher's #does_not_match?" do
        RSpec::Matchers.define :have_my_key do |expected|
          match_for_should_not do |actual|
            !actual.has_key?(expected)
          end
        end

        h = {:special => true}
        expect {
          h.should_not have_my_key(:special).in(0.1)
        }.to raise_error
      end
    end

    context "#soon" do
      it "is an alias for #in(30)" do
        expect {
          link(:id => "toggle").click
        }.to make {div(:id => "div1").present?}.soon
      end
    end

    context "#make" do
      it "is an alias for #change" do
        expect {
          text_field(:name => "field1").clear
        }.to make {text_field(:name => "field1").value.empty?}
      end
    end
  end

end
