# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
require 'nokogiri'
require 'uri'

# Go fetch the contents of a URL & store them as a String
response = open('http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html')
doc = Nokogiri::HTML(response)

# will return to this to come up with a better solution than this hacky array with spaced strings. Regex will probably be the direction to make this better
months = ["January ", "February ", "March ", "April ", "May ", "June ", "July ", "August ", "September ", "October ", "November ", "December "]

def absolute_url(href)
	page_url = 'http://www2.stat.duke.edu/courses/Spring01/sta114/data/andrews.html'
	absolute_uri = URI.join( page_url, href).to_s
end

doc.xpath('//table/tr').each do |tr|
	td1, description = tr.xpath('./td')
	if months.any? { |month| description.content.include?(month) }
#refactored for better hash output thanks to https://stackoverflow.com/questions/9336039/get-link-and-href-text-from-html-doc-with-nokogiri-ruby
		rows = {}
		td1.xpath('./a').map do |link|
			name = link.text.gsub(/[[:space:]]+/, "")
			url = absolute_url(link['href'])
			rows[name] = url
		end

		command, *the_rest = ARGV #ARGV is an array created by ruby from command line arguments
		if rows.key?(command)
			download = open(rows[command])
			IO.copy_stream(download, "output.dat") #https://ruby-doc.org/core-1.9.2/IO.html, with matching command line argument, program will create output.dat and transfer table data automatically
		elsif !command
			rows.each do |key, value|
				puts "#{key}	#{value}"
			end
		end
	end		
end

#spent a long time trying to figure out how to remove html entity &nbsp; correctly and converting it to whitespace. I went down a long rabbit hole that gave me 3 different options and none really worked for my solution so I just removed all whitespace for now. The normalize method seems like a solid direction to go, so I will play with that more after getting other parts of the challenge to work.