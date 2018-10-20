require 'rubygems'
require 'nokogiri'
require 'open-uri'
class Scrap
	def getemail(url,nom)
		c = 0
		email = []
		url.each do |url|
			page = Nokogiri::HTML(open(url))
			page.css("tr:nth-child(6) td.hotelvalue a:nth-child(1)").each do |href|
			email[c] = href.text
			c += 1
			end
		end
		hashs = nom.zip(email).to_h

		return hashs
	end

	def getNomCommune
		c_1 = 0
		c_2 = 0
		nom = []
		url = []
		page = Nokogiri::HTML(open("https://www.annuaire-administration.com/mairie/departement/mayotte.html"))
		page.css(".departement_commune  tr td a:nth-child(1)").each do |href|
			nom[c_2] = href.text
			url[c_1] = href['href']
			c_1 += 1
			c_2 += 1
		end

		page = Nokogiri::HTML(open("https://www.annuaire-administration.com/mairie/departement/guyane.html"))
		page.css(".departement_commune  tr td a:nth-child(1)").each do |href|
			nom[c_2] = href.text
			url[c_1] = href['href']
			c_1 += 1
			c_2 += 1
		end

		page = Nokogiri::HTML(open("https://www.annuaire-administration.com/mairie/departement/la-reunion.html"))
		page.css(".departement_commune  tr td a:nth-child(1)").each do |href|
			nom[c_2] = href.text
			url[c_1] = href['href']
			c_1 += 1
			c_2 += 1
		end
		getemail(url,nom)
	end



end

