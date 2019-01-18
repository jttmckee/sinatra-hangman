require 'sinatra'
require 'sinatra/reloader'
require './hangman.rb'
require 'YAML'

enable :sessions

get '/' do
  if session[:game] then hangman = YAML::load(session['game'])
  else hangman = Hangman.new
  end
  message = params['letter'] ?
    hangman.checkLetter(params['letter'][0].upcase ) :
    "<BR>Please type a letter<BR>"
  display = hangman.printLetters
  session[:game] = hangman.save_game
  if hangman.lives <= 0
    session[:game] = nil
    message << "\n<BR>You Lose!  The word was: #{hangman.word}<BR>\n"
    show = :finish
  elsif hangman.hasWon == true
    session[:game] = nil
    message << "\n<BR>You Win!<BR>\n"
    show = :finish
  else
    show = :home
  end
  erb show, locals: {message: message, display: display}
end
