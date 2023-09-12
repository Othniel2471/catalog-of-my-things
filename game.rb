require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, multiplayer, last_played_at)
    super(publish_date) # Call the parent class's constructor
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && (Date.today - @last_played_at).to_i > 730
  end
end
