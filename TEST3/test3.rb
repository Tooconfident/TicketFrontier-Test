require 'date'

def process(document)
	result = []
	file = document
	columns = []
	File.readlines(file).each do |line|
		records = line.split(' ')		
		year = records[6]
		columns << year
	end
	p columns
end

process("T08 (1).1")

class Record
  # Looking at the people.csv file,
  # what attributes should a Person object have?
  attr_reader :table_number, :sub_table, :record_number, :day_of_week, :day_of_month, :month, :year, :total_deaths, :wounded

  def initialize(args = {})
    @table_number = args[:table_number]
    @sub_table = args[:sub_table]
    @record_number = args[:record_number]
    @day_of_week = args[:day_of_week]
    @day_of_month = args[:day_of_month]
    @month = args[:month]
    @year = args[:year]
    @total_deaths = args[:total_deaths]
    @wounded = args[:wounded]
  end
end