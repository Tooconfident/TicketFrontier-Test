# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
require 'nokogiri'

# Go fetch the contents of a URL & store them as a String
response = open('http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html')
doc = Nokogiri::HTML(response)

rows = {}
months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]


doc.xpath('//table/tr').each do |tr|
		td1, description = tr.xpath('./td')
		links = td1.xpath('./a').map {|link| link['href']}
		#https://stackoverflow.com/questions/10215590/check-if-string-contains-any-substring-in-an-array-in-ruby

		if months.any? { |month| description.content.include?(month) } 
			table_name = td1.content.split(/[[:space:]]/).join
			rows= {table_name => links}
			p rows
		end
	end


# puts rows

#spent a long time trying to figure out how to remove html entity &nbsp; correctly. I went down a long rabbit hole that gave me 3 different options and none really worked for my solution so I just removed all whitespace for now