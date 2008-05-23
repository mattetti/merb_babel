require File.dirname(__FILE__) + '/spec_helper'
  
describe '#localize' do
  
  before(:each) do
    Merb::Controller.send :include, Merb::GlobalHelpers
    @c = dispatch_to(TestController, :index)
    @c.add_localization_dir(File.expand_path(File.dirname(__FILE__) + "/lang"))
    @c.load_localization!
  end

  it "should localize a word in english " do
      @c.locale.should == 'en-US'
      @c.language.should == 'en'
      @c.country.should == 'US'
      @c.localize(:left).should == 'left'
  end
  
end