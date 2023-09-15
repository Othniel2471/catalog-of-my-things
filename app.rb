require 'json'
require 'date'
require_relative 'game'
require_relative 'author'
require 'fileutils'
require_relative 'label'
require_relative 'book'
require './music_album'
require './genre'

class App
  def initialize
    FileUtils.mkdir_p('Data')
    @books = []
    @labels = []
    read_books
    read_labels
  end

  def read_books
    File.new('Data/books.json', 'w') unless File.exist?('Data/books.json')
    books = File.read('Data/books.json')
    return if books.empty?

    JSON.parse(books).each do |book|
      publish = book['publish_date'].split('-')
      @books.push(Book.new(Date.new(publish[0].to_i, publish[1].to_i, publish[2].to_i),
                           book['publisher'], book['cover_state'],
                           Label.new(book['label']['title'], book['label']['color'])))
    end
  end

  def read_labels
    File.new('Data/labels.json', 'w') unless File.exist?('Data/labels.json')
    labels = File.read('Data/labels.json')
    return if labels.empty?

    JSON.parse(labels).each do |label|
      @labels.push(Label.new(label['title'], label['color']))
    end
  end

  def write_book_data
    book_file = []
    label_file = []

    @books.each do |book|
      book_file.push({ publish_date: book.publish_date, publisher: book.publisher, cover_state: book.cover_state,
                       label: { title: book.label.title, color: book.label.color } })
    end

    @labels.each do |label|
      label_file.push({ title: label.title, color: label.color })
    end

    File.write('Data/books.json', JSON.pretty_generate(book_file))
    File.write('Data/labels.json', JSON.pretty_generate(label_file))
  end

  def list_books
    puts 'No books yet' if @books.empty?
    @books.each do |book|
      puts "[#{book.label.title}] Publisher: #{book.publisher} Cover State: #{book.cover_state}"
    end
  end

  def list_labels(index: false)
    puts 'No labels yet' if @labels.empty?
    puts 'Available labels:' unless index || @labels.empty?
    @labels.each_with_index do |label, idx|
      print "#{idx + 1} - " if index
      puts "[#{label.color.capitalize}] #{label.title.capitalize}"
    end
    return unless index

    puts '0 - Create a label'
    puts ''
    gets.chomp.to_i
  end

  def add_book
    print 'Publish Date (yyyy-dd-mm): '
    publish_date = gets.chomp
    publish = publish_date.split('-')
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
    book = Book.new(Date.new(publish[0].to_i, publish[1].to_i, publish[2].to_i), publisher, cover_state, label)
    label.add_item(book)
    @books << book
    puts 'Book added successfully!'
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
