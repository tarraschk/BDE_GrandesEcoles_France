# encoding: UTF-8

baseUrl = 'www.cge.asso.fr/nos-membres/ecoles/'
filter = '$(".right-column h3 a").attr("href");'
split = '.split("www")[1];'

# ------------
# DEPENDENCIES
# ------------
require 'faraday'
require 'faraday_middleware'
require 'json'
require 'watir-webdriver'

puts '==== CGE ===='
puts 'Fetching CGE data...'
# Fetching your Facebook Tinder token & id
browser = Watir::Browser.new
(1..500).each do |i|
  browser.goto baseUrl+i.to_s
  if browser.text.include? "Page non trouvée"
    next
  else
    nom_ecole_object = browser.div(:id => "fiche-ecole").div(:class => "right-column").h2
    url_object = browser.div(:id => "fiche-ecole").div(:class => "right-column").h3
    if nom_ecole_object.exists? && url_object.exists?
      nom_ecole = nom_ecole_object.text
      url = url_object.text
      
      if url.empty?
        next
      end
      
      #Ici, manipulez les données
      email = String.new(url)
      email = email.split("/")[0]
      email_tab = email.split(".")
      email_tab.shift
      email = "bde@"+email_tab.join(".")
      puts nom_ecole+";;"+url+";;"+email
      
    end
  end
end

browser.close
