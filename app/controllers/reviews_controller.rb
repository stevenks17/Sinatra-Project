

class ReviewsController < ApplicationController

    get '/review_entries' do 
        @review_entries = Review.all
        erb :'review_entries/index'
    end

    get 'review_entries/new' do
        redirect_if_not_logged_in
        erb :'review_entries/new'
    end

    post 'review_entries' do
        redirect_if_not_logged_in
        if params[:content] != ""
            @review_entry = Review.create(content: params[:content], user_id: current_user.id, title: params[:title])
            redirect "review_entries/#{@review_entry.id}"
        else
            redirect 'review_entries/new'
        end
    end

    get 'review_entries/:id/edit' do
        redirect_if_not_logged_in
        set_review_entry
        if @review_entry == current_user && params[:content] != ""
            @review_entry.update(content: params[:content])
            redirect "/review_entries/#{@review_entry.id}"
        else
            redirect "users/#{current_user.id}"
        end
    end

    delete '/review_entries/:id' do
        set_review_entry
        if authorized_to_edit?(@review_entry)
            @review_entry.destroy
            redirect '/review_entries'
        else
            redirect '/review_entries'
        end
    end

    private

    def set_review_entry
        @review_entry = Review.find(params[:id])
    end

    
end