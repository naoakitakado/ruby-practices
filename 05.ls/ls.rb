# !/usr/bin/env ruby
# frozen_string_literal: true

def dirsearch
  option = ARGV
  option = [] if ARGV == 'nil'
  return Dir.glob('**/*', File::FNM_DOTMATCH) if option.include?('-a')
  return Dir.glob('*') if option.empty?
end

def rowcalculation(items, display_row_number)
  row_number = items.length / display_row_number
  row_number + 1 unless (items.length % display_row_number).zero?
end

def fileshaping(dir_items)
  file_word_count = dir_items.map(&:length)
  dir_items.map { |item| item.ljust(file_word_count.max) }
end

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

DISPLAY_ROW_NUMBER = 3
dir_items = dirsearch
items = fileshaping(dir_items)
row_number = rowcalculation(items, DISPLAY_ROW_NUMBER)
lineoutput(row_number, items)
