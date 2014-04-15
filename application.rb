require 'sinatra/base'
require_relative './user_repository'

class Application < Sinatra::Application

  def initialize(app=nil)
    super(app)
  end

  enable :sessions

  get '/' do
    #session[:email] ||= nil
    erb :index, locals: {email: session[:email]}
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    email = params[:email]
    password = params[:password]
    user_table = DB[:users]
    user_table.insert(email: email, password_digest: password)
    session[:email] = email
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end