# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
require 'nokogiri'

# Go fetch the contents of a URL & store them as a String
response = open('http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html')
doc = Nokogiri::HTML(response)

# rows = []
months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

doc.xpath('//table/tr').each do |tr|
		td1, description = tr.xpath('./td')
		links = td1.xpath('./a').map {|link| link['href']}
		#https://stackoverflow.com/questions/10215590/check-if-string-contains-any-substring-in-an-array-in-ruby
		if months.any? { |month| description.content.include?(month) } 
			puts td1.content, links
		end
	end


# puts rows