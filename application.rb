require 'sinatra/base'
require_relative './user_repository'

class Application < Sinatra::Application

  def initialize(app=nil)
    super(app)

    # initialize any other instance variables for you
    # application below this comment. One example would be repositories
    # to store things in a database.

  end

  get '/' do
    erb :index
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    new_user = DB[:users]
    new_user.insert(email: params[:email], password_digest: params[:password])
    redirect '/'
  end
end