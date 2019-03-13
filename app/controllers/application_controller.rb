require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "sinatra_travel"
    register Sinatra::Flash
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
     User.find(session[:user_id])
    end

    def if_not_logged_in
      if !logged_in?
        flash[:message] = "You are currently not logged in"
        redirect '/login'
      end
    end
  end

end
