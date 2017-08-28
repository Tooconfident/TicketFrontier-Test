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
        array << line.split.map(&:to_i)
        # puts line.class
      end
      # p array[6]
	 end
  end
end


test = Record.new
test.process("T08.1")