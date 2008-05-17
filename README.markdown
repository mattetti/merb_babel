merb_abel
=========

A plugin for the Merb framework that provides locales, languages, countries. (multi threaded)
In your controller add:

    before :set_locale
    

and access the user locale using  @controller.locale
If a locale is set, you can also access @controller.language and @controller.country

The locale is stored in request.env[:locale]

At the moment you have 3 ways of setting up a locale:
* default way in the config settings, overwite:

    Merb::Plugins.config[:merb_abel] = {
      :default_locale => 'en-US',
      :default_language => 'en',
      :default_country => 'US'
    }
    
* per request basis, by sending a param called locale
* store the locale in the session
* use routes

Abel doesn't support http header lookup yet.

Set locale in your routes
--------------------------

    r.match(/\/?(en\-US|en\-UK|es\-ES|es\-AR)?/).to(:locale => "[1]") do |l|
      l.match("/articles/:action/:id").to(:controller => "articles")
    end

Purpose of merb_abel
---------------------

merb_abel is being written to fulfill my personal needs. Instead of porting my http://github.com/matta/globalite plugin over, I decided to re write it from scratch learning from my mistakes.

Goals:

* simplicity
* speed

My first and simple objective is to get Merb to work in Simplified and Traditional Chinese + switch from one to the other. Chinese doesn't use pluralization so don't expect to see this feature right away.

Also, as of today, I'm not planning on supporting model localization since I believe it's easy to do, and in most cases it's too specific to use a plugin. (and other plugins offer that for you anyway ;) )

One of the objectives is that people can require merb_abel and use merb in a different language without worrying about internationalization/localization. I hope to keep merb helpers and other plugins (merb_activerecord) localized so someone can define his app's locale/language/country and Merb will talk the dev language right away.

Other plugins you might want to look at:
----------------------------------------

* http://github.com/myabc/merb_global
* http://github.com/lemon/poppycock