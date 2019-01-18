require 'yaml'
class Hangman

  attr_reader :hasWon, :lives, :letters, :incorrect_letters


  def initialize
    @hasWon = false
    @lives = 5
    @scaffold = []
    @scaffold << "     --------"
    @scaffold << "        |"
    @scaffold << "        O"
    @scaffold << "       -|-"
    @scaffold << "       / \\"
    @letters = []
    @incorrect_letters = []

    words = File.readlines('5desk.txt')
    @word = ""
    until (@word.size <= 11 && @word.size >= 5)
      @word = words[rand(words.size)].chomp.upcase
    end
  end

  def checkLetter(letter)
    message = ""
    if @incorrect_letters.include?(letter) or @letters.include?(letter)
      message << "You already guessed that letter.\n<BR>"
    elsif letter =~ /[A-Z]/
      message << "You guessed \"#{letter}\""
      if @word.include? letter
        message << "That's right! Well done..."
        @letters << letter
        hasWon = true if @word.split('').all? {|chr| @letters.include?(chr)}
      else
        @lives -= 1
        message << "That's wrong!\n"
        @incorrect_letters << letter
      end
    else
      message << "That's not a letter"
    end
    message << "You have #{@lives} lives left."
    message << "Already guessed: #{incorrect_letters.join(', ')}"

  end

  def printLetters()
    display = "\n<BR>"
    (5 - @lives).times do |i|
      display << "#{@scaffold[i]} \n<BR>"
    end
    display << "\n<BR>"

    display << "WORD: "
    @word.each_char do |chr|
      display << (@letters.include?(chr) && chr ? chr : '_')
      display << ' '
    end
    display
  end

  def save_game
    YAML::dump(self)
  end

end
