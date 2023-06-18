class Game
  attr_accessor :display, :player, :current_guess
  @@tries = 0
  def initialize
    @display = Display.new()
    @player = Player.new()
    @current_guess = ""
  end

  def start_game
    word = File.readlines("wordbank.txt").sample.to_s.delete("\n")
    puts word
    puts display.display_blanks(word)
    self.current_guess = display.display_current_status(word)
    while @@tries < 10
      guess = player.get_letter_guess
      check_guess(word, guess, self.current_guess)
    end
  end

  def check_guess(word, guess, current_guess)
    word.each_char.with_index do |char, i|
      if guess == char
        current_guess.sub!(current_guess[i], guess)
      else
        next
      end
    end
    puts current_guess
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


game = Game.new()
game.start_game
