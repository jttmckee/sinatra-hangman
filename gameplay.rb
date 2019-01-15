require './hangman.rb'

def load_game
  saved_game = File.read('game.save')
  a = YAML::load(saved_game)
  a.play
end
puts "Would you like to load the previously saved game? Y/N"
if gets.upcase[0] == 'Y'
   load_game
else
  a = Hangman.new
end
