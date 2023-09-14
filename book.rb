require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state, :publish_date, :id

  def initialize(publish_date, publisher, cover_state, label = nil)
    publish = publish_date.split('-')
    super(Date.new(publish[0].to_i, publish[1].to_i, publish[2].to_i))
    @publisher = publisher
    @cover_state = cover_state
    self.label = label if label
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
