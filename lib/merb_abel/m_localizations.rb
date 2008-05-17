module MLocalizations
  
  def languages
    @@languages ||= []
  end
  
  def defaut_language
    Merb::Plugins.config[:merb_abel] ? Merb::Plugins.config[:merb_abel][:default_language] : nil
  end
  
  
end