require 'date'
require 'matrix'

class Record
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

  def process(file)
    my_data = []
	  File.open(file) do |f|
		  f.each_line do |line|
        my_data << line.split
      end
      by_year(my_data)
    end
  end


  def by_year(data)
    years_on_record = []
      data.each do |accident|
        if years_on_record.any? {|year| year[:year] == accident[6]}
          desired_index = years_on_record.index { |year| year[:year] == accident[6]}
          years_on_record[desired_index][:accidents] = years_on_record[desired_index][:accidents] + 1
          years_on_record[desired_index][:total_wounded] += accident[9].to_i
          years_on_record[desired_index][:total_killed] = accident[7].to_i
          years_on_record[desired_index][:average_wounded] = years_on_record[desired_index][:total_wounded].to_f / years_on_record[desired_index][:accidents].to_f
          years_on_record[desired_index][:average_killed] = years_on_record[desired_index][:total_killed].to_f / years_on_record[desired_index][:accidents].to_f
        else
          years_on_record << { :year => accident[6], 
                        :accidents => 1, 
                        :total_wounded => accident[9].to_i, 
                        :total_killed => accident[7].to_i, 
                        :average_wounded => accident[9].to_f, 
                        :average_killed => accident[7].to_f 
                      }
        end
      end
      p years_on_record
  end

end


test = Record.new
test.process("T08.1")

#smashing
#build hash, in hash yuo would have hash of hashes
#each hash would have parameter would be year
#next #wonded

# myYears = []

# For each row in my_data
#   if my_years
#       if year.year == row.year
#         year.accidents += 1
#         year.total_wounded += row.killed
#         year.total_killed += row.total_killed
#         year.average_wounded = year.total_wounded / year
#         year.average_killed = year.total_killed / year.accidents
#else

# myYears.any? {|year| year[:year] == 'blah'}
# myYears.any? {|year| year[:year] == '1851'}

# myYears = []


