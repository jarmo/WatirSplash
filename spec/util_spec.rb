describe WatirSplash::Util do

  it "loads ui-test-common" do
    ui_test_common_dir = "../ui-test-common"
    raise "ui-test-common directory should not exist due to testing!" if File.exists?(ui_test_common_dir)
    begin
      FileUtils.mkdir(ui_test_common_dir)
      File.open(File.join(ui_test_common_dir, "environment.rb"), "w") do |f|
        f.puts "
module GlobalApplication
  LOADED = true
end"
      end

      lambda {GlobalApplication::LOADED}.should raise_exception
      lambda {WatirSplash::Util.load_common}.should_not raise_exception
      GlobalApplication::LOADED.should be_true
    ensure
      FileUtils.rm_rf(ui_test_common_dir)
    end
  end

  it "raises exception if ui-test-common is not found" do
    lambda {WatirSplash::Util.load_common}.
            should raise_exception(RuntimeError,
                                   "ui-test-common directory was not found! It has to exist somewhere higher in directory tree than your project's directory and it has to have environment.rb file in it!")
  end

end
