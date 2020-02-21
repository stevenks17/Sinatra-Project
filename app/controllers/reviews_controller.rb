
class ReviewsController < ApplicationController
    

    #READ
    get '/review_entries' do 
     @review_entries = Review.all
     erb :'review_entries/index'
    end
    
    #CREATE
    get '/review_entries/new' do
     redirect_if_not_logged_in
     erb :'review_entries/new'
    end

    
    #CREATE 
    post '/review_entries' do
        redirect_if_not_logged_in
        if params[:content] != ""
            @review_info = Review.create(content: params[:content], user_id: current_user.id, title: params[:title])
            redirect "review_entries/#{@review_info.id}"
        else
            redirect 'review_entries/new'
        end
    end
    

     #READ
    get '/review_entries/:id' do
     set_review_info
     erb :'/review_entries/show'
    end

    #UPDATE
    get '/review_entries/:id/edit' do
     set_review_info
     authorized?(@review_info)
     erb :'review_entries/edit'
    end

    #UPDATE
    patch '/review_entries/:id' do
     set_review_info
     authorized?(@review_info)
     @review_info.update(params)
    end

   #DELETE
    delete '/review_entries/:id' do
     set_review_info
     authorized?(@review_info)
     @review_info.destroy
     redirect '/'
    end

   

    def set_review_info
     @review_info ||= Review.find_by(id: params[:id])
    end
   


   
    
end