#! /usr/bin/env ruby
#
# usage: seq2text.rb [midi_file]
#
# This script translates a MIDI file into text. It reads the file into
# a MIDI::Sequence and calls to_s for each event.
#
# For a different (and more verbose) way to do the same thing, see
# reader2tex.rb.
#

# Start looking for MIDI module classes in the directory above this one.
# This forces us to use the local copy, even if there is a previously
# installed version out there somewhere.
$LOAD_PATH[0, 0] = File.join(File.dirname(__FILE__), '..', 'midi')

require 'midilib/sequence'

# Read from MIDI file
seq = MIDI::Sequence.new()

File.open(ARGV[0] || DEFAULT_MIDI_TEST_FILE, 'rb') { | file |
  # The block we pass in to Sequence.read is called at the end of every
  # track read. It is optional, but is useful for progress reports.
  seq.read(file) { | track, num_tracks, i |}
}

seq.each { | track |
  track.each { | e |
    if e.is_a? MIDI::NoteOn
    	e.print_decimal_numbers = true # default = false (print hex)
    	e.print_note_names = true # default = false (print note numbers)
    	puts e
    end
  }
}