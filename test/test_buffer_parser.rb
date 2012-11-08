# Test Harness Helpers
require 'minitest/autorun'
require 'purdytest'
require 'pry'

# Load SUT
require_relative '../lib/buffer_parser.rb'

class TestVimBufferParser < MiniTest::Unit::TestCase

  include VimBufferParser

  def test_parse_buster_test_name_basic
    # Falsy
    assert_nil(parse_buster_test_name("foo"))
    assert_nil(parse_buster_test_name("  foo "));

    # Truthy - Single Quotes
    assert_equal('foo', parse_buster_test_name('"foo":function(){}'))
    assert_equal('foo bar', parse_buster_test_name('"foo bar":function(){}'))

    # Truthy - Double Quotes
    assert_equal("foo", parse_buster_test_name('"foo":function(){}'))
    assert_equal("foo bar", parse_buster_test_name('"foo bar":function(){}'))
    assert_equal("foo bar", parse_buster_test_name('   "foo bar":function(){}    '))

    # Truthy - Test name with colon character
    assert_equal("foo:bar", parse_buster_test_name('"foo:bar":function(){}'))
    assert_equal("foo:bar:baz", parse_buster_test_name('"foo:bar:baz":function(){}'))
    assert_equal(":", parse_buster_test_name('":":function(){}'))
  end

  def test_parse_name_lifecycle
    # Falsy - Setup & Teardown Method
    assert_nil(parse_buster_test_name('buster.testCase("foo", {'))
    assert_nil(parse_buster_test_name('setup: function(){}'))
    assert_nil(parse_buster_test_name('teardown: function(){}'))
  end

  def test_parse_name_spec
    # Falsy - Setup & Teardown Method
    assert_equal("foo bar:baz", parse_buster_test_name('it("foo bar:baz", function () {'))
    assert_equal("foo bar:baz", parse_buster_test_name('it(  "foo bar:baz", function () {'))
  end

end
