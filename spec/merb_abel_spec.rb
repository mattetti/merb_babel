require File.dirname(__FILE__) + '/spec_helper'

Merb.load_dependencies(:environment => 'test')

class TestController < Merb::Controller
  include MLocale::Controller
  
  before :set_locale
  def index; end
end

class LanguageController < Merb::Controller
  include MLocale::Controller
  
  before :set_locale
  def index; end
end


describe 'using set_locale, ' do
  describe 'a controller' do
  
    describe 'locale' do
    
      it "should be set by default" do
        c = dispatch_to(TestController, :index)
        c.locale.should == 'en-US'
      end
  
      it "should be able to be set by passing a param" do
        c = dispatch_to(TestController, :index, :locale => 'fr-FR')
        c.locale.should == 'fr-FR'
      end
      
      it "should be able to be set using the session" do
        c = dispatch_to(TestController, :index) do |controller|
          controller.stub!(:session).and_return( :locale => "es-BO" )
        end
        c.locale.should == 'es-BO'
      end
    
    end
  
    describe 'language' do 
    
      it "should be set by default" do
        c = dispatch_to(TestController, :index)
        c.language.should == 'en'
      end
  
      it "should be able to be set by passing a param" do
        c = dispatch_to(TestController, :index, :language => 'fr')
        c.language.should == 'fr'
      end
    
      it "should bet set when a locale was set by params" do
        c = dispatch_to(TestController, :index, :locale => 'fr-FR')
        c.locale.should == 'fr-FR'
        c.language.should == 'fr'
      end
      
      it "should bet set when a locale was set by session" do
        c = dispatch_to(TestController, :index) do |controller|
          controller.stub!(:session).and_return( :locale => "es-BO" )
        end
        c.language.should == 'es'
      end
  
    end
  
    describe 'country' do

      it "should be set by default" do
        c = dispatch_to(TestController, :index)
        c.country.should == 'US'
      end
    
      it "should be able to be set by passing a param" do
        c = dispatch_to(TestController, :index, :country => 'ES')
        c.country.should == 'ES'
      end
      
      it "should bet set when a locale was set by params" do
        c = dispatch_to(TestController, :index, :locale => 'fr-FR')
        c.country.should == 'FR'
      end
      
      it "should bet set when a locale was set by session" do
        c = dispatch_to(TestController, :index) do |controller|
          controller.stub!(:session).and_return( :locale => "es-BO" )
        end
        c.country.should == 'BO'
      end
  
    end
    
  end
end

describe 'using set_language, ' do
  describe 'a controller' do
    describe 'language' do 
    
      it "should be set by default" do
        c = dispatch_to(LanguageController, :index)
        c.language.should == 'en'
      end
  
      it "should be able to be set by passing a param" do
        c = dispatch_to(LanguageController, :index, :language => 'fr')
        c.language.should == 'fr'
      end
  
    end
  end
end