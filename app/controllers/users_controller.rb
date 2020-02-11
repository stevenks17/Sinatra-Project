class UsersController < ApplicationController
   
  get "/signup" do
    erb :signup
  end
    
  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect '/failure'
    else
     User.create(username: params[:username], password: params[:password])
        redirect '/signup'
      end
    end
    
  get "/login" do
    erb :login
  end
    
  post "/login" do
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
        redirect to "/signup"
      else
        redirect to "/failure"
      end
    end
    
  get "/failure" do
    erb :failure
  end
    
  get "/logout" do
    session.clear
     redirect "/"
  end
    

      




end