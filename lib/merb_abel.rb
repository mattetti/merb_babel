require File.join(File.dirname(__FILE__) / "merb_abel" / "core_ext")

# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_babel] = {
    :default_locale => 'en-US',
    :default_language => 'en',
    :default_country => 'US',
    :localization_dirs => ["#{Merb.root}/lang"]
  }
  
  require File.join(File.dirname(__FILE__) / "merb_abel" / "m_locale")
  require File.join(File.dirname(__FILE__) / "merb_abel" / "m_l10n")
  require File.join(File.dirname(__FILE__) / "merb_abel" / "m_i18n")
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
    module Merb
      module GlobalHelpers
        include ML10n

        def localize(key, *args)
          options = args.first 
          options ||= {}
          options.merge!(:key => key)
          options.merge!(:language => language) unless options.has_key?(:language)
          options.merge!(:country => country) unless options.has_key?(:country)
          MI18n.lookup(options)
        end
        alias :l :localize

      end
    end
    
    Merb::Controller.send(:include, MLocale)
    Merb::Controller.send(:include, ML10n)
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
    Merb::Controller.send(:load_localization!)
  end
  
  Merb::Plugins.add_rakefiles "merb_abel/merbtasks"
end
