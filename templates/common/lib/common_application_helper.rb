# You can create under this directory common libraries/helpers/methods which you would
# like to use within your specs in different projects

module CommonApplicationHelper

  # You can use methods declared in this module inside of your it-blocks
  # it "does something" do
  #   new_global_method.should == "it just works"
  # end
  def new_global_method
    "it just works"
  end

end