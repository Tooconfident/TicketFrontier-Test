require 'date'
require 'terminal-table'

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
    end
    by_year(my_data)
    by_weekday(my_data)
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
      display_by_year(years_on_record)
  end


  def display_by_year(array)
    array.each do |year| 
        puts "--------------BY YEAR-------------- \n
              #{year[:year]}\n
      Total Accidents: #{year[:accidents]}\n
      Average Wounded: #{year[:average_wounded]}\n
      Total Wounded: #{year[:total_wounded]}\n
      Average Killed: #{year[:average_killed]}\n
      Total Killed: #{year[:total_killed]}\n"
    end
  end

  def by_weekday(data)
    weekday_on_record = []
      data.each do |accident|
        if weekday_on_record.any? {|day| day[:day] == accident[3]}
          desired_index = weekday_on_record.index { |day| day[:day] == accident[3]}
          weekday_on_record[desired_index][:accidents] = weekday_on_record[desired_index][:accidents] + 1
          weekday_on_record[desired_index][:total_wounded] += accident[9].to_i
          weekday_on_record[desired_index][:total_killed] = accident[7].to_i
        else
          weekday_on_record << { :day => accident[3], 
                        :accidents => 1, 
                        :total_wounded => accident[9].to_i, 
                        :total_killed => accident[7].to_i, 
                      }
        end
      end
      display_by_weekday(weekday_on_record)
  end

  def display_by_weekday(array)
    array.each do |day| 
        puts "----------BY WEEKDAY----------\n
              #{day[:day]}\n
      Total Accidents: #{day[:accidents]}\n
      Total Wounded: #{day[:total_wounded]}\n
      Total Killed: #{day[:total_killed]}\n\n"
    end
  end

end


test = Record.new
test.process("T08.1")
