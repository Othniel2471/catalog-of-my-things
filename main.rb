require './app'

puts 'Welcome to my catalog!'.center(50).upcase

def main
  app = App.new

  loop do
    puts ''
    puts 'What do you want to do?'
    puts '1 - List All Books'
    puts '2 - List all music albums'
    puts '3 - List all games'
    puts "4 - List all genres (e.g 'Comedy', 'Thriller')"
    puts "5 - List all labels (e.g. 'Gift', 'New')"
    puts "6 - List all authors (e.g. 'J. K. Rowling', 'Stephen King')"
    puts '7 - Add a book'
    puts '8 - Add a music album'
    puts '9 - Add a game'
    puts '0 - Exit'
    puts ''

    option = gets.chomp.to_i
    exit if option.zero?
    list(option, app)

    break if option.zero?
  end
end

def book_menu; end

def list(option, app)
  list_main(option, app) if option.positive? && option < 4
  list_sub(option, app) if option > 3 && option < 7
  list_add(option, app) if option > 6 && option < 10
end

def list_main(option, app)
  case option
  when 1
    puts 'List All Books'
  when 2
    app.music_album_list
  when 3
    puts 'List all games'
  end
end

def list_sub(option, app)
  case option
  when 4
    app.genre_list
  when 5
    puts "List all labels (e.g. 'Gift', 'New')"
  when 6
    puts "List all authors (e.g. 'J. K. Rowling', 'Stephen King')"
  end
end

def list_add(option, app)
  case option
  when 7
    puts 'Add a book'
  when 8
    app.add_music_album
  when 9
    puts 'Add a game'
  end
end

def exit
  puts 'Goodbye!'
end

main
