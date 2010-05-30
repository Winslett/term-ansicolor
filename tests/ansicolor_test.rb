#!/usr/bin/env ruby

require 'test/unit'
require 'ansiterm/ansicolor'

class String
  include AnsiTerm::ANSIColor
end

class Color
  extend AnsiTerm::ANSIColor
end

class ANSIColorTest < Test::Unit::TestCase
  include AnsiTerm::ANSIColor

  def setup
    @string = "red"
    @string_red = "\e[31mred\e[0m"
    @string_red_on_green = "\e[42m\e[31mred\e[0m\e[0m"
  end

  attr_reader :string, :string_red, :string_red_on_green

  def test_red
    assert_equal string_red, string.red
    assert_equal string_red, Color.red(string)
    assert_equal string_red, Color.red { string }
    assert_equal string_red, AnsiTerm::ANSIColor.red { string }
    assert_equal string_red, red { string }
  end

  def test_red_on_green
    assert_equal string_red_on_green, string.red.on_green
    assert_equal string_red_on_green, Color.on_green(Color.red(string))
    assert_equal string_red_on_green, Color.on_green { Color.red { string } }
    assert_equal string_red_on_green,
      AnsiTerm::ANSIColor.on_green { AnsiTerm::ANSIColor.red { string } }
    assert_equal string_red_on_green, on_green { red { string } }
  end


  def test_uncolored
    assert_equal string, string_red.uncolored
    assert_equal string, Color.uncolored(string_red)
    assert_equal string, Color.uncolored { string_red }
    assert_equal string, AnsiTerm::ANSIColor.uncolored { string_red }
    assert_equal string, uncolored { string }
  end

  def test_attributes
    foo = 'foo'
    for (a, _) in AnsiTerm::ANSIColor.attributes
      assert_not_equal foo, foo_colored = foo.__send__(a)
      assert_equal foo, foo_colored.uncolored
      assert_not_equal foo, foo_colored = Color.__send__(a, foo)
      assert_equal foo, Color.uncolored(foo_colored)
      assert_not_equal foo, foo_colored = Color.__send__(a) { foo }
      assert_equal foo, Color.uncolored { foo_colored }
      assert_not_equal foo, foo_colored = AnsiTerm::ANSIColor.__send__(a) { foo }
      assert_equal foo, AnsiTerm::ANSIColor.uncolored { foo_colored }
      assert_not_equal foo, foo_colored = __send__(a) { foo }
      assert_equal foo, uncolored { foo }
    end
  end
end
