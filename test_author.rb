require 'minitest/autorun'
require_relative 'author'
require_relative 'game'

class TestAuthor < Minitest::Test
  def setup
    @author = Author.new('John', 'Doe')
    @game = Game.new(Date.new(2023, 4, 15), true, Date.new(2023, 9, 9))
  end

  def test_add_item
    assert_empty @author.items

    @author.add_item(@game)
    assert_equal 1, @author.items.length
    assert_equal @author, @game.author
  end

  def test_full_name
    assert_equal 'John Doe', @author.full_name
  end
end
