require_relative 'label'
require_relative 'book'

class App
  def initialize
    @books = []
    @labels = []
  end

  def list_books
    puts 'No books yet' if @books.empty?
    @books.each do |book|
      puts "[#{book.label.title}] Publisher: #{book.publisher} Cover State: #{book.cover_state}"
    end
  end

  def list_labels(index: false)
    puts 'No labels yet' if @labels.empty?
    @labels.each_with_index do |label, idx|
      print "#{idx + 1} - " if index
      puts label.title
    end
    return unless index

    puts '0 - Create a label'
    gets.chomp.to_i
  end

  def add_book
    print 'Publish Date (yyyy-dd-mm): '
    publish_date = gets.chomp.to_i
    print 'Publisher: '
    publisher = gets.chomp
    print 'Cover State: '
    cover_state = gets.chomp
    puts 'Choose a label:'
    label_index = list_labels(index: true)
    label = if label_index.zero?
              create_label
            else
              @labels[label_index - 1]
            end
    book = Book.new(publish_date, publisher, cover_state)
    label.add_item(book)
    @books << book
    puts "Book #{book.publisher} added!"
  end

  private

  def create_label
    print 'Title: '
    title = gets.chomp
    print 'Color: '
    color = gets.chomp
    label = Label.new(title, color)
    @labels << label
    label
  end
end
