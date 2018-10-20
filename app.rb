require 'bundler'
require 'dotenv'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'gmail'
require 'twitter'
Dotenv.load
Bundler.require
$:.unshift File.expand_path("./../lib", __FILE__)
require 'townhalls_scrapper'
require 'townhalls_mailer'
data = Scrap.new.getNomCommune
File.open("db/emails.JSON","w") do |f|
	f.write(data.to_json)
end

json = File.read('db/emails.JSON')
data = JSON.parse(json)
 gmail = Gmail.connect(ENV["gmail_user"], ENV["gmail_password"])

 data.each do |key,value|
 	if value =~ /@/ then
 		mail_send(value, gmail)
 	else
 		puts value
 	end
 end
 gmail.logout


 client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

data.each do |key, value|
	client.search(key).take(1).collect do |tweet|
		puts 'OK'
  		client.follow(tweet.user.screen_name)
	end
end

