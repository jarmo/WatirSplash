# you can create under this directory common libraries/helpers/methods which you could
# use within your specs in different projects

module CommonApplicationHelper

  # you can use these methods automatically inside of your it-blocks
  # it "does something" do
  #   new_global_method.should == "it just works"
  # end
  def new_global_method
    "it just works"
  end

end