class ApplicationController < ActionController::Base

	# Define the Entry object
	class Entry
		def initialize(title, link)
			@title = title
			@link  = link
		end
		attr_reader :title
		attr_reader :link
	end
	
	def scrape_site
		# Pull in the page
		require 'open-uri'
		doc = Nokogiri::HTML(open("https://www.repubblica.it/"))
		
		# Narrow down on what we want and build the entries array
		@entries = doc.css('.entry__title')
		@entriesArray = []
		@entries.each do |entry|
			title = entry.css('a').text
			link = entry.css('a')[0]['href']
			@entriesArray << Entry.new(title, link)
		end
	end
	
end
