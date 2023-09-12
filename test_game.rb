require 'minitest/autorun'
require_relative 'game'

class TestGame < Minitest::Test
  def setup
    @publish_date = Date.new(2023, 4, 15)
    @multiplayer = true
    @last_played_at = Date.today - 731 # More than 2 years ago
    @game = Game.new(@publish_date, @multiplayer, @last_played_at)
  end

  def test_can_be_archived
    # Test when the game can be archived
    assert @game.can_be_archived?

    # Test when the game cannot be archived
    @game.last_played_at = Date.new(2023, 9, 8)
    refute @game.can_be_archived?
  end
end
