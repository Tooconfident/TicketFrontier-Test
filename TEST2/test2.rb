# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
require 'nokogiri'

# Go fetch the contents of a URL & store them as a String
response = open('http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html')
doc = Nokogiri::HTML(response)

puts doc.xpath('//table')