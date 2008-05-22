require File.dirname(__FILE__) + '/spec_helper'
  
describe '#localize' do
  
  before(:each) do
    Merb::Controller.send :include, Merb::GlobalHelpers
  end

  it "should localize a word in english " do
    c = dispatch_to(TestController, :index) do |c|
      c.locale.should == 'en-US'
      c.language.should == 'en'
      c.country.should == 'US'
      c.localize(:left).should == 'left'
    end

  end
  
end