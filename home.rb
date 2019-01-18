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
    hangman.checkLetter(params['letter'][0].upcase ) : "Please type a letter"
  display = hangman.printLetters
  session[:game] = hangman.save_game
  erb :home, locals: {message: message, display: display}
end
