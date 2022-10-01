# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def dirsearch
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:a] = v }
  opt.on('-r') { |v| params[:r] = v }

  opt.parse!(ARGV)
  if params[:a]
    Dir.glob('**/*', File::FNM_DOTMATCH)
  elsif params[:r]
    Dir.glob('*').reverse
  else
    Dir.glob('*')
  end
end

def rowcalculation(items, display_row_number)
  row_number = items.length / display_row_number
  row_number += 1 unless (items.length % display_row_number).zero?
  row_number
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
  items_cut = items.each_slice(row_number).to_a
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
