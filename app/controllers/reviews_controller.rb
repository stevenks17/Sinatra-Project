require 'pry'

class ReviewsController < ApplicationController

    get '/review_entries' do 
        @review_entries = Review.all
        erb :'review_entries/index'
    end

    get '/review_entries/new' do
        redirect_if_not_logged_in
        erb :'review_entries/new'
    end

    post '/review_entries' do
        redirect_if_not_logged_in
        if params[:content] != ""
            @review_info = Review.create(content: params[:content], user_id: current_user.id, title: params[:title])
            #binding.pry
            redirect "review_entries/#{@review_info.id}"
        else
            redirect 'review_entries/new'
        end
    end

    get '/review_entries/:id' do
        set_review_info
        erb :'/review_entries/show'
    end

    get '/review_entries/:id/edit' do
        redirect_if_not_logged_in
        set_review_info
        authorized_to_edit?(@review_info)
        erb :'review_entries/edit'
  
    end

    patch '/review_entries/:id/edit' do
        redirect_if_not_logged_in
        set_review_info
        authorized_to_edit?(@review_info)

        if @review_info.update(params[:content])
            redirect "/review_entries/#{@review_info.id}"
        else
            erb :"review_entries/edit"
        end
    end

    delete '/review_entries/:id' do
        set_review_info
        if authorized_to_edit?(@review_info)
            @review_info.destroy
            redirect '/review_entries/show'
        else
            redirect '/review_entries/show'
        end
    end

    
    def set_review_info
        @review_info = Review.find_by_id(params[:id])
    end


   
    
end