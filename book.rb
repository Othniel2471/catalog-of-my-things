require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state, :publish_date, :id

  def initialize(publish_date, publisher, cover_state, label = nil)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state
    self.label = label if label
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
