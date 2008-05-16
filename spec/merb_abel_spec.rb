require File.dirname(__FILE__) + '/spec_helper'

class TestController < Merb::Controller
  include MLocale::Controller
  before :set_locale
  def index; end
end

describe 'merb_abel' do
  
  it "should set a default locale" do
    c = dispatch_to(TestController, :index)
    c.locale.should == 'en-US'
  end
  
  it "should be able to set a locale by passing a param" do
    c = dispatch_to(TestController, :index, :locale => 'fr-FR')
    c.locale.should == 'fr-FR'
  end
  
  it "should set a default language" do
    c = dispatch_to(TestController, :index)
    c.language.should == 'en'
  end
  
  it "should be able to set a language by passing a param" do
    c = dispatch_to(TestController, :index, :language => 'fr')
    c.language.should == 'fr'
  end
  
  it "should set a language when it sets a locale" do
    c = dispatch_to(TestController, :index, :locale => 'fr-FR')
    c.locale.should == 'fr-FR'
    c.language.should == 'fr'
  end
  
end