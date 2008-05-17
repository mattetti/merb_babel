require File.join(File.dirname(__FILE__) / "merb_abel" / "core_ext")

# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_abel] = {
    :default_locale => 'en-US',
    :default_language => 'en',
    :default_country => 'US',
    :localization_dirs => ["#{Merb.root}/lang"]
  }
  
  require File.join(File.dirname(__FILE__) / "merb_abel" / "m_locale")
  require File.join(File.dirname(__FILE__) / "merb_abel" / "m_l10n")
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
    Application.send(:include, MLocale)
    Application.send(:include, ML10n)
  end
  
  Merb::Plugins.add_rakefiles "merb_abel/merbtasks"
end
