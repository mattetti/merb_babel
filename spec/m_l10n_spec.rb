require File.dirname(__FILE__) + '/spec_helper'

describe "ML10n" do
  
  before(:each) do
    @lang_test_path = File.expand_path(File.dirname(__FILE__) + "/lang")
    @lang_test_path_2 = File.expand_path(File.dirname(__FILE__) + "/other_lang_dir")
    ML10n.reset_localization_files_and_dirs!
  end
  
  it "should have a list of localization directories" do
    ML10n.localization_dirs.should == Merb::Plugins.config[:merb_babel][:localization_dirs]
  end
  
  it "should be able to add a new localization directory" do
    ML10n.add_localization_dir(@lang_test_path)
    ML10n.localization_dirs.include?(@lang_test_path)
  end
  
  it "should have a list of localization source files" do
    ML10n.localization_files.should == []
    ML10n.add_localization_dir(@lang_test_path)
    ML10n.localization_files.include?("#{@lang_test_path}/en.yml").should be_true
    ML10n.localization_files.include?("#{@lang_test_path}/en-US.yml").should be_true
  end
  
  it "should load localization files and have them available" do
    ML10n.add_localization_dir(@lang_test_path)
    ML10n.load_localization!
    ML10n.localizations['en'][:right].should == 'right'
    ML10n.localizations['en'][:left].should == 'left'
    ML10n.localizations['en']['US'][:greetings].should == 'Howdie'
  end
  
  it "should load more localization files and have them available" do
    ML10n.add_localization_dir(@lang_test_path)
    ML10n.load_localization!
    ML10n.localizations['en'][:right].should == 'right'
    ML10n.localizations.has_key?('fr').should be_false
    
    ML10n.add_localization_dir(@lang_test_path_2)
    ML10n.load_localization!
    ML10n.localizations['en'][:right].should == 'right'
    ML10n.localizations.has_key?('fr').should be_true
    ML10n.localizations['fr'][:right].should == 'la droite'
    ML10n.localizations['fr'][:left].should == 'la gauche'
    ML10n.localizations['fr'][:greetings].should == 'Salut'
  end
  
end