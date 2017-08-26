def process(document)
	result = []
	file = document
	columns = []
	File.readlines(file).each do |line|
		records = line.split(' ')		
		year = records[6]
		p year
	end
	
end

process("T08 (1).1")