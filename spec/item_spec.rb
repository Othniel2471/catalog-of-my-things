require_relative '../item'

describe Item do
  before(:each) do
    @item = Item.new(Date.new(2000, 1, 1))
  end

  describe '#initialize' do
    it 'creates a new item' do
      expect(@item).to be_a(Item)
    end

    it 'should have an ID' do
      expect(@item.id).to be_a(Integer)
    end
  end

  describe '#can_be_archived?' do
    it 'should return true if the item is older than 10 years' do
      expect(@item.can_be_archived?).to be_truthy
    end

    it 'should return false if the item is not older than 10 years' do
      @item.publish_date = Date.today
      expect(@item.can_be_archived?).to be_falsey
    end
  end

  describe '#move_to_archive' do
    it 'should move the item to the archive' do
      @item.move_to_archive
      expect(@item.archived).to be_truthy
    end
  end
end
