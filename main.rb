require_relative "lib/colors"
require_relative 'lib/display'
require_relative 'lib/player'
require_relative 'lib/game'
require_relative 'lib/database'

include Database

def main_menu
  puts "Welcome to the Game!"
  puts "1. Start a New Game"
  puts "2. Load a Saved Game"
  puts "3. Exit"
  print "Enter your choice: "
  choice = gets.chomp.to_i

  case choice
  when 1
    start_new_game
  when 2
    load_old_game
  when 3
    exit
  else
    puts "Invalid choice. Please try again."
    main_menu
  end
end

def start_new_game
  game = Game.new
  game.new_game
end

def load_old_game
  game = load_game
  game.old_game
end

# Call the main menu to start the game
main_menu
