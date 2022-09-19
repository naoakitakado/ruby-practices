# !/usr/bin/env ruby
# frozen_string_literal: true

def lineoutput(row_number, items)
  line = lineshaping(row_number, items)
  line.each do |item|
    puts item.join('   ')
  end
end

def lineshaping(row_number, items)
  ascending_items = items.sort
  items_cut = ascending_items.each_slice(row_number).to_a
  items_cut.each do |item_cut|
    item_cut << '' while item_cut.size < row_number
  end
  items_cut.transpose
end

max = 0
DISPLAY_ROW_NUMBER = 3

dir_items = Dir.glob('*')

dir_items.each do |item|
  max = item.size if item.size > max
end

items = dir_items.map { |item| item.ljust(max) }

row_number = items.length / DISPLAY_ROW_NUMBER
row_number += 1 unless (items.length % DISPLAY_ROW_NUMBER).zero?

lineoutput(row_number, items)
