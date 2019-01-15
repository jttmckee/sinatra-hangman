require 'yaml'
class Hangman

  def play

    hasWon = false

    letter = ""
    until (@lives<=0 || hasWon)
      printLetters()
       loop do
         letter = getLetter

        if @incorrect_letters.include?(letter) or @letters.include?(letter)
          puts "You already guessed that letter."
        elsif letter =~ /[A-Z]/
          break
        elsif letter == '+'
          save_game
        else
          puts "That's not a letter!"
        end
      end

      puts "You guessed \"#{letter}\""
      if @word.include? letter
        puts "That's right! Well done..."
        @letters << letter
        if @word.split('').all? {|chr| @letters.include?(chr)} then hasWon = true end
      else
        @lives -= 1
        puts "That's wrong! You have #{@lives} lives left."
        @incorrect_letters << letter

      end

    end

    if hasWon
      puts "You win!"
    else

      puts "You lose!"
    end
    puts "The word is \"#{@word}\""
  end

  def initialize
    setup

    play

  end

  private

  def getLetter
    puts "Guess a letter (A - Z).  Only the first letter counts.  Type \"+\" to save."
    letter =  gets[0].upcase

  end

  def printLetters()
    print "\n"
    (5 - @lives).times do |i|
      puts @scaffold[i]
    end
    puts "\n"

    print "WORD:"
    @word.each_char do |chr|
      print @letters.include?(chr) ? chr : '_'
      print ' '
    end

  end

  def setup
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

  def save_game
    puts "Game saved"

    f = File.open('game.save','w')
    f.puts YAML::dump(self)
    f.close

  end

end
