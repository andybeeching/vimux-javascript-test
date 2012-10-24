# Test Harness Helpers
require 'minitest/autorun'
require 'purdytest'
require 'pry'

# Load SUT
require_relative '../lib/buffer_parser.rb'

class TestVimBufferParser < MiniTest::Unit::TestCase

  include VimBufferParser

  def test_parse_test_name
    # Falsy
    assert_equal(parse_test_name("foo"), nil)
    assert_equal(parse_test_name("  foo "), nil)

    # Truthy - Single Quotes
    assert_equal('foo', parse_test_name('"foo":function(){}'))
    assert_equal('foo bar', parse_test_name('"foo bar":function(){}'))

    # Truthy - Double Quotes
    assert_equal("foo", parse_test_name('"foo":function(){}'))
    assert_equal("foo bar", parse_test_name('"foo bar":function(){}'))
    assert_equal("foo bar", parse_test_name('   "foo bar":function(){}    '))
  end

end
