
# The MLocale module helps you set up a locale, language, country
# You don't have to use a locale, in some cases you might just want to use the language
module MLocale
  def locale_from_request
    if hal = request.env["HTTP_ACCEPT_LANGUAGE"]
      hal.gsub!(/\s/, "")
      result = hal.split(/,/).map do |v|
        v.split(";q=")
      end.map do |j|
        [j[0], j[1] ? j[1].to_f : 1.0]
      end.sort do |a,b|
        -(a[1] <=> b[1])
      end.map do |v|
        Locale::Tag.parse(v[0])
      end.first
      return nil if result.nil?
      language = result.language
      country = result.country ||
        LocaleDetector.country_from_language(language)
      request.env[:locale] = "#{language}-#{country}"
    end
  end

  # A locale is made of a language + country code, such as en-UK or en-US 
  def locale 
    request.env[:locale] || params[:locale] || (session ? session[:locale] : nil) || locale_from_request || default_locale
  end
  
  # Many people don't care about locales, they might just want to use languages instead
  def language
    request.env[:language] || params[:language] || language_from_locale || (session ? session[:language] : nil) || default_language
  end
  
  # The country is used when localizing currency or time
  def country
    request.env[:country] || params[:country] || country_from_locale || (session ? session[:country] : nil) || LocaleDetector.country_from_language(language) || default_country
  end
  
  # Extract the language from the locale
  def language_from_locale
    if request.env[:locale] && request.env[:locale] =~ locale_regexp
      language, country = request.env[:locale].match(locale_regexp).captures
      return language
    else 
      return nil
    end
  end
  
  # Extract the country from the locale
  def country_from_locale
    request.env[:locale] ? request.env[:locale][3..5].upcase : nil
  end
  
  # Defaults set in the plugin settings
  # You can change the default settings by overwriting 
  # the Merb::Plugins.config[:merb_abel] hash in your settings
  #
    def default_locale
      Merb::Plugins.config[:merb_babel] ? Merb::Plugins.config[:merb_babel][:default_locale] : nil
    end

    def default_language
      Merb::Plugins.config[:merb_babel] ? Merb::Plugins.config[:merb_babel][:default_language] : nil
    end
  
    def default_country
      Merb::Plugins.config[:merb_babel] ? Merb::Plugins.config[:merb_babel][:default_country] : nil
    end
  #
  #### end of defaults
  
  protected

    def locale_regexp
      /(.+)\-([a-z]{2})/i
    end
    
    # You can extend this method in application.rb
    # example:
    #
    #   def set_locale
    #     super
    #     session[:language] = language
    #   end
    #
    #
    # takes a locale as in fr-FR or en-US
    def set_locale
      if locale =~ locale_regexp
        language, country = locale.match(locale_regexp).captures
        # Set the locale, language and country
        language = language.downcase
        country = country.upcase
        request.env[:locale] = "#{language}-#{country}"
      end
      
    end
  
    def set_language
      request.env[:language] = language.downcase
    end
end