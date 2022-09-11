# !/usr/bin/env ruby
# frozen_string_literal: true

require 'rubocop'

def lsprocess(row, date)
  swap_rows_and_columns = dateshaping(row, date)
  swap_rows_and_columns.each do |x|
    puts x.join('  ')
  end
end

def dateshaping(row_number, before_date)
  ascending_order_current_file_or_directory = before_date.sort
  ascending_order_current_file_or_directory_array = ascending_order_current_file_or_directory.each_slice(row_number).to_a

  max = ascending_order_current_file_or_directory_array.max_by(&:size).size
  ascending_order_current_file_or_directory_array.each do |a|
    a << '' while a.size < max
  end
  ascending_order_current_file_or_directory_array.transpose
end

display_row = 3
current_file_or_directory = Dir.glob('*')
lsprocess(display_row, current_file_or_directory)
