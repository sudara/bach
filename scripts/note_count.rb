#! /usr/bin/env ruby
#
# Goes through everything in ../midi/*.mid and counts notes per file/total
require 'midilib/sequence'

# Read from MIDI file
seq = MIDI::Sequence.new()

total_count = 0

Dir["../midi/*.mid"].each do |file|
  file_count = 0
  puts file.split('/').last
  
  File.open(file) do |f|
    seq.read(f)
  end

  seq.each do |track|
    track.each do |e|
      if e.is_a? MIDI::NoteOn
        total_count++
        file_count++
      end
    end
  end
  puts "  #{file_count} notes"
end

puts "-" * 20
puts "#{total_count} notes in total"