#require File.join(File.dirname(__FILE__) / "merb_babel" / "core_ext")

# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_babel] = {
    :default_locale => 'en-US',
    :default_language => 'en',
    # :default_country => 'US',
    :localization_dirs => ["#{Merb.root}/lang"]
  }
  
  require File.join(File.dirname(__FILE__) / "merb_babel" / "m_locale")
  require File.join(File.dirname(__FILE__) / "merb_babel" / "m_l10n")
  require File.join(File.dirname(__FILE__) / "merb_babel" / "m_i18n")
  require File.join(File.dirname(__FILE__) / "merb_babel" / 'locale_detector')
  gem "locale"
  require 'locale'
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
    module Merb
      module GlobalHelpers

        # Used to translate words using localizations
        def babelize(*args)
          begin
            options = args.pop if args.last.kind_of?(Hash) 
            options ||= {}
            options[:language] ||= language
            options[:country] ||= country
            case key = args.last
            when Date, Time
              format = MI18n.lookup(options.merge(:keys => args[0..-2]))
              ML10n.localize_time(key, format, options)
            else
              MI18n.lookup(options.merge(:keys => args))
            end
          rescue
            key.to_s
          end
        end
        alias :translate :babelize
        alias :t :babelize
        alias :_ :babelize
      end
    end
    
    Merb::Controller.send(:include, MLocale)
    ML10n.load_localization!
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "merb_babel/merbtasks"
end
