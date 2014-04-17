require 'sinatra/base'
require 'bcrypt'
require_relative './user_repository'

class Application < Sinatra::Application

  def initialize(app=nil)
    super(app)
  end

  enable :sessions

  get '/' do
    erb :index, locals: {email: session[:email]}
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    email = params[:email]
    password = params[:password]

    password_hash = BCrypt::Password.create(password)

    user_table = DB[:users]
    user_table.insert(email: email, password_digest: password_hash)
    session[:email] = email
    redirect '/'
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    email = params[:email]
    password = params[:password]

    my_user = DB[:users].where(email: email).to_a.first
    my_email = my_user[:email]
    my_password = my_user[:password_digest]

    password_hash = BCrypt::Password.new(my_password)
    if (email == my_email) && (password_hash == password)
      session[:email] = email
      redirect '/'
    else
      redirect '/'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end