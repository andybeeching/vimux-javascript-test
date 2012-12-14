# Module for testing parsing algos for use in the Vim plugin
# Note: This module is not being 'included' in the Vim file
#       Thus it requires manual syncing, but the suite has
#       proved useful given Vim's lack of tooling for creating
#       plugins in ruby.
#
# Buster test format:
# "STRING": function () { asserts... }
# Pass method name as string to CLI
#   e.g. buster test "foo"
#   NOTE: treated as a RegExp for fuzzy matching
#   Can't run test case (should be one per file anyway)

module VimBufferParser

  # Method to parse a string for a buster test|spec case
  # Accepts any string (inc. whitespace)
  # Returns test name or nil
  def parse_buster_test_name(line)
    return if line =~ /setup|teardown|testCase|describe/

    # Branch on test flavour
    if line =~ /it\(/
      # it("yield 0 in score for gutter game", function () {
      parts = line.split("it(")[1].split(",")
    else
      # Test for key:value object member syntax + check for method
      parts = line.split(":")
    end

    # Try and prevent false positives by checking for a function
    return unless parts.length && parts.last =~ /function/

    # Disco!
    parts.pop
    parts.join(":").scan(/([^"|']+)/)
    $1
  end

end
