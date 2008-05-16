module MLocale
  
  module Controller
    
    # A locale is made of a language + country code, such as en-UK or en-US 
    def locale 
      params[:locale] || (session ? session[:locale] : nil) || Merb::Plugins.config[:merb_abel][:default_locale]
    end
    
    # many people don't care about locales, they might just want to use languages instead
    def language
      params[:language] || language_from_locale ||(session ? session[:language] : nil) || Merb::Plugins.config[:merb_abel][:default_language]
    end
    
    # extract the language from the locale
    def language_from_locale
      request.env[:locale] ? request.env[:locale][0..1].downcase : nil
    end
    
    protected
  
      # takes a locale as in fr-FR or en-US
      def set_locale
        language, country = locale.match(/([a-z]{2})\-([a-z]{2})/i).captures
        
        # Set the locale, language and country
        unless language.nil? || country.nil?
          language = language.downcase
          country = country.upcase
          request.env[:locale] = "#{language}-#{country}"
        end
        
      end
    
      def set_language
        request.env[:language] = language.downcase
      end
    
  end
  
end