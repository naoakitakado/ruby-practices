# !/usr/bin/env ruby
# frozen_string_literal: true

user_score = ARGV[0]
scores = user_score.split(',')
shots = []
scores.each do |score|
  if score == 'X'
    shots << 10
    shots << 0 if shots.size <= 17
  else
    shots << score.to_i
  end
end

frames = []
shots.each_slice(2) do |frame|
  frames << frame if frame.size == 2
  frames.last.push(frame[0]) if frame.size == 1
end

point = 0
frames.each_with_index do |frame, frame_number|
  if frame[0] == 10
    point += frames[frame_number + 1][0] + frames[frame_number + 1][1] if frame_number != 9
    point += frames[frame_number + 2][0] if frames[frame_number + 1] == [10, 0]
  elsif frame.sum == 10
    point += frames[frame_number + 1][0] if frame_number != 9
  end
  point += frame.sum
end
puts point
