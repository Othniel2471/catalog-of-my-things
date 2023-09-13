require_relative '../book'

describe Book do
  let(:book) { Book.new(Date.new(2000, 1, 1), 'Publisher', 'Good') }

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

  describe '#move_to_archive' do
    it 'should archive the book if it can be archived' do
      book.move_to_archive
      expect(book.archived).to be_truthy
    end

    it 'should not archive the book if it cannot be archived' do
      book.publish_date = Date.today
      book.move_to_archive
      expect(book.archived).to be_falsey
    end
  end
end
