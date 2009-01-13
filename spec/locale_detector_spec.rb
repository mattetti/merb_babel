require File.dirname(__FILE__) + '/spec_helper'

describe 'country detector' do
  it "should detect country from request" do
    c = dispatch_to(TestController, :index, {},
      'HTTP_ACCEPT_LANGUAGE' => 'en-UK')
    c.country.should == 'UK'
  end

  it "should detect language from request" do
    c = dispatch_to(TestController, :index, {},
      'HTTP_ACCEPT_LANGUAGE' => 'fr-FR')
    c.language.should == 'fr'
  end

  it "should detect full locale from request" do
    c = dispatch_to(TestController, :index, {},
      'HTTP_ACCEPT_LANGUAGE' => 'en-UK')
    c.locale.should == 'en-UK'
  end

  it "should detect full locale from request 2" do
    c = dispatch_to(TestController, :index, {},
      'HTTP_ACCEPT_LANGUAGE' => 'en_UK')
    c.language.should == 'en'
    c.country.should == 'UK'
    c.locale.should == 'en-UK'
  end
end
