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
    # One way - check number of splits, OR just check the last one has function?
    parts = line.split(":")
    return unless parts.length && parts.last =~ /function/

    # So far so good! Parse out the test name (returned via magic var)
    parts.pop
    parts.join(":").scan(/([^"|']+)/)
    $1
  end

end
