# !/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'
require 'rubocop'

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0 if shots.size <= 17
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s if s.size == 2
  frames.last.push(s).flatten! if s.size == 1
end

point = 0
frames.each_with_index do |frame, frame_number|
  if frame[0] == 10
    case frame_number
    when 8
      point += frames[frame_number + 1][0] + frames[frame_number + 1][1]
    else
      point += frames[frame_number + 1][0] + frames[frame_number + 1][1] if frame_number != 9
      point += frames[frame_number + 2][0] if frames[frame_number + 1] == [10, 0]
    end

  elsif frame.sum == 10
    point += frames[frame_number + 1][0] if frame_number != 9
  end
  point += frame.sum
end
p point
