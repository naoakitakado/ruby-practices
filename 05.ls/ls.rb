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
  max = items_cut.max_by(&:size).size

  if items_cut.count == 1
    test = items_cut.flatten.map do |o|
      o.tr(' ', '')
    end
    puts test.join('   ')
    exit
  else
    items_cut.each do |a|
      a << '' while a.size < max
    end
    items_cut.transpose
  end
end

max = 0
DISPLAY_ROW_NUMBER = 3

dir_items = Dir.glob('*')

dir_items.each do |item|
  max = item.size if item.size > max
end

items = dir_items.map { |item| item.ljust(max) }

lineoutput(DISPLAY_ROW_NUMBER, items)
