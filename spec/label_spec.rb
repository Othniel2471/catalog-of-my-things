require_relative '../label'
require_relative '../book'

describe Label do
  let(:label) { Label.new('Label', 'red') }
  let(:book) { Book.new('2020-01-01', 'Publisher', 'Good') }

  describe '#initialize' do
    it 'should create a new label' do
      expect(label).to be_a(Label)
    end
  end

  describe '#add_item' do
    it 'should add an item to the label' do
      label.add_item(book)
      expect(label.items).to include(book)
    end
  end

  describe '#items' do
    it 'should return an array of items' do
      expect(label.items).to be_a(Array)
    end
  end

  describe '#title' do
    it 'should return the label title' do
      expect(label.title).to eq('Label')
    end
  end

  describe '#color' do
    it 'should return the label color' do
      expect(label.color).to eq('red')
    end
  end
end
