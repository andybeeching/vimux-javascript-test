# Module for testing parsing algos for use in the Vim plugin
# Note: This module is not being 'included' in the Vim file
#       Thus it requires manual syncing, but the suite has
#       proved useful given Vim's lack of tooling for creating
#       plugins in ruby.
#
module VimBufferParser

  # Method to parse a string for a buster test case
  # Accepts any string (inc. whitespace)
  # Returns test name or nil
  def parse_test_name(line)
    # Rudimentary test for key:value object member syntax + check for method sig
    line = line.split(":")
    return unless line.length && line[1] =~ /function/

    # So far so good! Parse out the test name (returned via magic var)
    line[0].scan(/([^"|']+)/)
    $1
  end

end
