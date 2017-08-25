# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
require 'nokogiri'

# Go fetch the contents of a URL & store them as a String
response = open('http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html')
doc = Nokogiri::HTML(response)

# rows = []
months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

doc.xpath('//table/tr').each do |tr|
		td1, td2 = tr.xpath('./td')
		if months.any? { |month| td2.content.include?(month) }
			puts td1
		end
	end


# puts rows