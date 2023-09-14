require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :publish_date, :multiplayer, :last_played_at, :author

  def initialize(publish_date, multiplayer, last_played_at, author = nil)
    publish = publish_date.split('-')
    super(Date.new(publish[0].to_i, publish[1].to_i, publish[2].to_i)) # Call the parent class's constructor
    @multiplayer = multiplayer
    date = last_played_at.split('-')
    @last_played_at = Date.new(date[0].to_i, date[1].to_i, date[2].to_i)
    self.author = author if author
  end

  def can_be_archived?
    !@last_played_at.nil? && Date.today.year - @last_played_at.year > 2
  end
end
