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
    nom_ecole = browser.div(:id => "fiche-ecole").div(:class => "right-column").h2.text
    url = browser.div(:id => "fiche-ecole").div(:class => "right-column").h3.text
    email = String.new(url)
    email = email.split("/")[0]
    email_tab = email.split(".")
    email_tab.shift
    email = "bde@"+email_tab.join(".")
    puts nom_ecole+";;"+url+";;"+email
  end
end

browser.close
