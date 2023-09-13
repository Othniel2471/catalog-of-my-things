require 'date'
class Item
  attr_accessor :genre, :author, :label

  def initialize(publish_date)
    @id = rand(1..1000)
    @publish_date = publish_date
    @archived = false
    move_to_archive
  end

  def can_be_archived?
    Date.today.year - publish_date.year > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
