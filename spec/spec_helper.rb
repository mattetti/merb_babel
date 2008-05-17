$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require "rubygems"
require "merb-core"
require 'merb_abel'
Merb.load_dependencies :environment => "test"

Spec::Runner.configure do |config|
  # config.include(Merb::Test::ViewHelper)
  config.include Merb::Test::RouteHelper
  config.include Merb::Test::RequestHelper
  config.include Merb::Test::ControllerHelper
end