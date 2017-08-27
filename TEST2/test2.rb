# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
require 'nokogiri'
require 'uri'

# Go fetch the contents of a URL & store them as a String
response = open('http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html')
doc = Nokogiri::HTML(response)

# rows = {}
months = ["January ", "February ", "March ", "April ", "May ", "June ", "July ", "August ", "September ", "October ", "November ", "December "]


doc.xpath('//table/tr').each do |tr|
	td1, description = tr.xpath('./td')
	if months.any? { |month| description.content.include?(month) }
#refactored for better hash output thanks to https://stackoverflow.com/questions/9336039/get-link-and-href-text-from-html-doc-with-nokogiri-ruby
		rows = Hash[td1.xpath('./a').map {|link| [link.text.gsub(/[[:space:]]+/, ""), File.expand_path(link["href"])]}]
		rows.each do |key, value|
			puts "#{key}	#{value}"
		end
	end		
end


# puts rows

#spent a long time trying to figure out how to remove html entity &nbsp; correctly. I went down a long rabbit hole that gave me 3 different options and none really worked for my solution so I just removed all whitespace for now