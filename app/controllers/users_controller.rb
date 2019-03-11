class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/sign_up'
    else
      redirect '/travels'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/travels'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "Log Out Successful."
      redirect '/'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Please Submit Valid Information"
      redirect '/signup'
    else
      @user = User.new(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/travels/new'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/travels'
    else
      flash[:message] = "Login Failed. Please Try Again."
      redirect '/login'
    end
  end
end
