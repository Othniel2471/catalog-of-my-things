require_relative '../book'

describe Book do
  let(:book) { Book.new('2001-09-09', 'Publisher', 'Good') }

  describe '#initialize' do
    it 'should create a new book' do
      expect(book).to be_a(Book)
    end
  end

  describe '#can_be_archived?' do
    it 'should return true if the book is older than 10 years' do
      expect(book.can_be_archived?).to be_truthy
    end

    it 'should return false if the book is not older than 10 years and the cover is good' do
      book.publish_date = Date.today
      expect(book.can_be_archived?).to be_falsey
    end

    it 'should return true if the book is older than 10 years or the cover is bad' do
      book.cover_state = 'bad'
      expect(book.can_be_archived?).to be_truthy
    end
  end
end
