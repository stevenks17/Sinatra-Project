require 'pry'


class UsersController < ApplicationController
   
  get "/login" do
    redirect_if_logged_in
    erb :'/login'
  end
   
  post '/login' do

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id 
      redirect "users/#{@user.id}"
    else
      redirect '/failure'
    end
  end

  get '/signup' do
    redirect_if_logged_in
    erb :signup
  end
    


  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect '/signup'
    end
  end
  
  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    redirect_if_not_logged_in
    erb :'/users/show'
  end

    
  get "/failure" do
    erb :failure
  end
    
  get "/logout" do
    session.clear
     redirect "/"
  end
    

      




end