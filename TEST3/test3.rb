def process(document)
	file = document
	File.readlines(file).each do |line|
		puts line
	end
end

process("T08 (1).1")