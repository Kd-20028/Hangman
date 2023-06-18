require_relative "colors"

class Game
  attr_accessor :display, :player, :current_guess, :incorrect_guesses
  @@tries = 10

  def initialize
    @display = Display.new()
    @player = Player.new()
    @current_guess = ""
    @incorrect_guesses = ""
  end

  def start_game
    word = File.readlines("wordbank.txt").sample.to_s.delete("\n")
    puts display.display_blanks(word)
    puts ""
    self.current_guess = display.display_current_status(word)
    while @@tries > 0
      guess = player.get_letter_guess
      puts ""
      check_guess(word, guess, self.current_guess)
        if self.current_guess == word
          puts "GAME OVER! YOU WIN!".green.bold
          break
        end
      puts "GUESSES REMAINING: #{@@tries}"
      puts ""
    end

    if @@tries == 0
      puts "GAME OVER! YOU LOSE!".red.bold
    end
  end

  def check_guess(word, guess, current_guess)
    found_match = false
    word.each_char.with_index do |char, i|
      if guess == char
        current_guess[i] = guess
        found_match = true
      end
    end

    unless found_match
       if self.incorrect_guesses["#{guess}"]
        puts "You already guess that!".red
        puts "Incorrect guesses: #{self.incorrect_guesses.red}\n"
       else
        self.incorrect_guesses += guess
        @@tries -= 1
        puts "Incorrect guess!".red
        puts "Incorrect guesses: #{self.incorrect_guesses.red}\n"
       end
    end

    if found_match
      puts "GOOD GUESS!".green
    end

    puts current_guess
    puts " "

  end

end

class Player
  attr_accessor :letterguess
  def initialize
    @letterguess
  end

  def get_letter_guess
    print "Enter A Letter: "
    self.letterguess = gets.chomp!.downcase
    self.letterguess.length != 1 ? get_letter_guess : self.letterguess
  end

end

class Display
  def display_blanks(word)
    blanks = ""
    word.each_char {|char| blanks += "_ "}
    blanks
  end

  def display_current_status(word)
    blanks = ""
    word.each_char {|char| blanks += "_"}
    blanks
  end
end

class SaveGame
  def initialize

  end
end

game = Game.new()
game.start_game
