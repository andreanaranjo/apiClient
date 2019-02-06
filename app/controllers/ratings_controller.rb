class RatingsController < ApplicationController
    require 'rest-client'

    API_BASE_URL = "http://localhost:3000/api"

    def index
        uri = "#{API_BASE_URL}/ratings.json"
        rest_resource = RestClient::Resource.new(uri)
        ratings = rest_resource.get
        @ratings = JSON.parse(ratings, :symbolize_names => true)        
    end

    def new
    end

    def create
        uri = "#{API_BASE_URL}/ratings"
        payload = params.to_json
        rest_resource = RestClient::Resource.new(uri)
        begin
            rest_resource.post payload , :content_type => "application/json"
            flash[:notice] = "Rating saved successfully"
            redirect_to_ratings_path
        rescue Exception => e
            flash[:error] = "Rating failed to save"
            render :new
        end
    end

    def edit
        uri = "#{API_BASE_URL}/ratings/#{params[:id]}/edit.json"
        rest_resource = RestClient::Resource.new(uri)
        ratings = rest_resource.get
        @rating = JSON.parse(ratings, :symbolize_names => true)
    end

    def update
        uri = "#{API_BASE_URL}/ratings/#{params[:id]}/update.json"
	    payload = params.to_json
	    rest_resource = RestClient::Resource.new(uri)
	    begin
	      rest_resource.put payload , :content_type => "application/json"
	      flash[:notice] = "Rating updated successfully"
	    rescue Exception => e
	      flash[:error] = "Raiting failed to update"
	    end
	    redirect_to ratings_path
    end
      
    def destroy
        uri = "#{API_BASE_URL}/ratings/#{params[:id]}/destroy.json"
	    rest_resource = RestClient::Resource.new(uri)
	    begin
	     rest_resource.delete
	     flash[:notice] = "Rating deleted successfully"
	    rescue Exception => e
	     flash[:error] = "Rating failed to delete"
	    end
	    redirect_to ratings_path
	end
	 
end
