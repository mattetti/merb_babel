require File.dirname(__FILE__) + '/spec_helper'

Merb.load_dependencies(:environment => 'test')

Merb::Router.prepare do |r|
  r.match(/\/?(en\-US|en\-UK|es\-ES|es\-AR)?/).to(:locale => "[1]") do |l|
    l.match("/tests").to(:controller => "test_controller")
  end
  r.match(/\/?(en|es|fr|de)?/).to(:language => "[1]") do |l|
    l.match("/languages").to(:controller => "language_controller")
  end
end


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
      
      it "should be set using an url (when the routes are set properly)" do
        #c = get('tests')
        #c.locale.should == 'en-US'
        c = get('en-US/tests')
        c.locale.should == 'en-US'
        c = get('en-UK/tests')
        c.locale.should == 'en-UK'
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
      
      it "should be set by the router" do
        c = get('fr/languages')
        c.language.should == 'fr'
        c.locale.should == 'en-US'
        # c = get('languages')
        # c.language.should == 'en'
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