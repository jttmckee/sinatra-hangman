require 'sinatra'
require 'sinatra/reloader'

enable :sessions

get '/' do
  "value = #{session[:value].inspect}"
end

get '/:value' do
  session['value'] = params['value']
end
