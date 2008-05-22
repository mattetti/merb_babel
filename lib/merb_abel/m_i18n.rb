module MI18n
  
  def self.lookup(options)
    language = options[:language]
    key = options[:key]
    raise ArgumentError, "You need to pass a language reference" unless language
    raise ArgumentError, "You need to pass a localization key" unless key
    raise ArgumentError, "language: #{language} not found" unless ML10n.localizations[language]
    
    ML10n.localizations[language][key]
  end
  
end