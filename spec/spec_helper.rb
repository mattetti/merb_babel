$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require "rubygems"
require "merb-core"
require 'merb_babel'
Merb.load_dependencies :environment => "test"

Spec::Runner.configure do |config|
  # config.include(Merb::Test::ViewHelper)
  config.include Merb::Test::RouteHelper
  config.include Merb::Test::RequestHelper
  config.include Merb::Test::ControllerHelper
end

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
  
  before :set_locale
  def index; end
end

class LanguageController < Merb::Controller
  
  before :set_language
  def index; end
end