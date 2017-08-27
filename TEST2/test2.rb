# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
require 'nokogiri'
require 'uri'

# Go fetch the contents of a URL & store them as a String
response = open('http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html')
doc = Nokogiri::HTML(response)

# rows = {}
months = ["January ", "February ", "March ", "April ", "May ", "June ", "July ", "August ", "September ", "October ", "November ", "December "]

def absolute_url(href)
	page_url = 'http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html'
	absolute_uri = URI.join( page_url, href).to_s
	# puts absolute_uri
end
doc.xpath('//table/tr').each do |tr|
	td1, description = tr.xpath('./td')
	if months.any? { |month| description.content.include?(month) }
#refactored for better hash output thanks to https://stackoverflow.com/questions/9336039/get-link-and-href-text-from-html-doc-with-nokogiri-ruby
		rows = {}
		td1.xpath('./a').map do |link| 
			rows[link.text.strip] = absolute_url(link['href'])
		end
		# puts rows
		# p link["href"]
		rows.each do |key, value|
			puts "#{key}	#{value}"
		end
	end		
end



# absolute_url("Andrews/T60.1")
# puts rows

#spent a long time trying to figure out how to remove html entity &nbsp; correctly. I went down a long rabbit hole that gave me 3 different options and none really worked for my solution so I just removed all whitespace for now