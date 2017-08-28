require 'date'

class Record
  # Looking at the people.csv file,
  # what attributes should a Person object have?
  # attr_reader :table_number, :sub_table, :record_number, :day_of_week, :day_of_month, :month, :year, :total_deaths, :wounded

  # def initialize(args = {})
  #   @table_number = args[:table_number]
  #   @sub_table = args[:sub_table]
  #   @record_number = args[:record_number]
  #   @day_of_week = args[:day_of_week]
  #   @day_of_month = args[:day_of_month]
  #   @month = args[:month]
  #   @year = args[:year]
  #   @total_deaths = args[:total_deaths]
  #   @wounded = args[:wounded]
  # end

  def process(file)
   array = []
	 File.open(file) do |f|
		  f.each_line do |line|
        array << line.split
      end
      by_year(array)
      
	 end
  end


  def by_year(row)
    counts = Hash.new(0)
    row.each do |inner|
      year = inner[6]
      counts[year] += 1
      
      # inner.each do |element| 
      #   counts[element] += 1 
      #if #year is a repeat
        #count += 1
        #total_accidents = count
      # end
      # p counts
      # total_accidents = # how many records that year, how many times we see the same year
      #wounded = # sum of inner[9].to_i divided by total_accidents
      #average_killed = #inner[8].to_i divided by total_accidents
      #total_killed = #highest value of inner[8].to_i
    end
    p counts
  end

end


test = Record.new
test.process("T08.1")