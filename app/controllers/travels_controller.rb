
class TravelsController < ApplicationController

  get '/travels' do
    if logged_in?
      @travels = Travel.all
      erb :'/travels/index'
    else
      flash[:message] = "You must be logged in to access your account."
      redirect '/login'
    end
  end

  get '/travels/new' do
    if logged_in?
      erb :'/travels/new'
    else
      redirect '/login'
    end
  end

  post '/travels' do
    if params[:itinerary] == ""
      redirect '/travels/new'
    else
      @travel = current_user.travels.create(itinerary: params[:itinerary], date_leave: params[:date_leave], date_return: params[:date_return], travel_purpose: params[:travel_purpose], notes: params[:notes])
      redirect to "/travels/#{@travel.id}"
    end
  end

  get '/travels/:id' do
    if logged_in?
      @travel = Travel.find(params[:id])
      erb :'/travels/show'
    else
      redirect '/login'
    end
  end

  get '/travels/:id/edit' do
    if logged_in?
      @travel = Travel.find(params[:id])
      @travel.user_id == current_user.id
      erb :'/travels/edit'
    else
      redirect '/login'
    end
  end

  patch '/travels/:id' do
    if params[:itinerary].empty?
      redirect "/travels/#{params[:id]}/edit"
    else
      @travel = Travel.find(params[:id])
      @travel.update(itinerary: params[:itinerary],date_leave: params[:date_leave], date_return: params[:date_return], travel_purpose: params[:travel_purpose], notes: params[:notes])
      @travel.save
      redirect "/travels/#{@travel.id}"
    end
  end

  delete '/travels/:id/delete' do
    @travel = Travel.find(params[:id])
    if logged_in? && current_user.id == @travel.user_id
      @travel.delete
      redirect '/travels'
    else
      redirect "/travels/#{@travel.id}"
    end
  end
end

