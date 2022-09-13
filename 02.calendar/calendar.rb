#!/usr/bin/env ruby
require "date"
require 'optparse'
opt = OptionParser.new


# コマンドライン引数処理
options = ARGV.getopts('y:m:')
year = options["y"].to_i
month = options["m"].to_i

year = Date.today.year if year.zero?
month = Date.today.month if month.zero?

last_date = Date.new(year, month, -1)
first_date = Date.new(year, month, 1)

SATURDAY = 6
ONEWEEK = 7
LASTDATE = last_date.day
week = []

puts "     #{month}月 #{year}    "
puts "日 月 火 水 木 金 土"
    
(first_date..last_date).each do |date|
  one_day = date.day
  one_day_of_week = date.wday
  one_day_shaped = one_day.to_s.rjust(2)
  week << one_day_shaped

  if one_day_of_week == SATURDAY
    if week.length != ONEWEEK
      blank_times = ONEWEEK - week.length
      blank_times.times{ week.unshift("  ") }
    end
    puts week.join(" ")
    week = []
  end
  puts week.join(" ") if one_day == LASTDATE
end
