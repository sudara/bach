#! /usr/bin/env ruby
#
# Goes through everything in ../midi/*.mid and counts notes per file/total
require 'midilib/sequence'

total_count = 0

Dir["../midi/*.mid"].each do |file|
  seq = MIDI::Sequence.new()
  
  file_count = 0
  puts file.split('/').last
  
  File.open(file) do |f|
    seq.read(f)
  end

  seq.each do |track|
    track.each do |e|
      if e.is_a? MIDI::NoteOn
        file_count += 1
      end
    end
  end
  puts "  #{file_count} notes"
  total_count += file_count
end

puts "-" * 25
puts "#{total_count} notes in total"