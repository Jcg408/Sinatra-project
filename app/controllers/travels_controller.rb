
class TravelsController < ApplicationController

  get '/travels' do
       if_not_logged_in
      @travels = Travel.all
      erb :'/travels/index'
  end

  get '/travels/new' do
    if_not_logged_in
      erb :'/travels/new'
  end

  post '/travels' do
    if_not_logged_in
    if params[:itinerary] == ""
      redirect '/travels/new'
    else
      @travel = current_user.travels.create(itinerary: params[:itinerary], date_leave: params[:date_leave], date_return: params[:date_return], travel_purpose: params[:travel_purpose], notes: params[:notes])
      redirect to "/travels/#{@travel.id}"
    end
  end

  get '/travels/:id' do
      if_not_logged_in
      @travel = Travel.find(params[:id])
      erb :'/travels/show'
  end

  get '/travels/:id/edit' do
    @travel = Travel.find(params[:id])
    # binding.pry
    if logged_in? && current_user.id == @travel.user_id
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
      if logged_in? && current_user.id == @travel.user_id
      @travel.update(itinerary: params[:itinerary],date_leave: params[:date_leave], date_return: params[:date_return], travel_purpose: params[:travel_purpose], notes: params[:notes])
      @travel.save
      end
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

