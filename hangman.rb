require 'yaml'
class Hangman

  attr_reader :hasWon, :lives, :letters, :incorrect_letters, :word


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
      message << "You guessed \"#{letter}\"<BR>"
      if @word.include? letter
        message << "That's right! Well done...<BR>"
        @letters << letter
        @hasWon = true if @word.split('').all? {|chr| @letters.include?(chr)}
      else
        @lives -= 1
        message << "That's wrong!\n<BR>"
        @incorrect_letters << letter
      end
    else
      message << "That's not a letter<BR>"
    end
    message << "You have #{@lives} lives left.<BR>"
    if incorrect_letters.size > 0
      message << "Already guessed: #{incorrect_letters.join(', ')}<BR>"
    end
    word = "WORD: "
    @word.each_char do |chr|
      word << (@letters.include?(chr) && chr ? chr : '_')
      word << ' '
    end
    word << "<BR><BR>"
    word + message
  end

  def printLetters()
    display = "\n<BR>"
    (5 - @lives).times do |i|
      display << "#{@scaffold[i]} \n<BR>"
    end
    display << "\n<BR>"


    display
  end

  def save_game
    YAML::dump(self)
  end

end
