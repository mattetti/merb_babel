module MI18n
  
  def self.lookup(options)
    key = options[:key].to_s.intern
    language = options[:language]
    country = options[:country]
    raise ArgumentError, "You need to pass a language reference" unless language
    raise ArgumentError, "You need to pass a localization key" unless key
    raise ArgumentError, "language: #{language} not found" unless ML10n.localizations[language]
    
    full_location = nil
    full_location = lookup_with_full_locale(key, language, country) if country
    
    if full_location
      return full_location
    else
      return ML10n.localizations[language][key] || key
    end
  end
  
  def self.lookup_with_full_locale(key, language, country)
    country = country.to_s.intern
    if ML10n.localizations.has_key?(language)
      ML10n.localizations[language].has_key?(country) ? ML10n.localizations[language][country][key.to_s] : nil 
    else
      nil
    end
  end
  
end
