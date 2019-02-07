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
        payload = params.to_json(:only => [:rating, :idMovie])
        rest_resource = RestClient::Resource.new(uri)
        begin
            rest_resource.post payload , :content_type => "application/json"
            flash[:notice] = "Rating saved successfully"
        rescue Exception => e
            flash[:error] = "Rating failed to save"
        end
        redirect_to root_path
    end

   # def edit
    #    uri = "#{API_BASE_URL}/ratings/#{params[:id]}/edit.json"
     #   rest_resource = RestClient::Resource.new(uri)
      #  ratings = rest_resource.get
       # @rating = JSON.parse(ratings, :symbolize_names => true)
    #end

    def edit
        uri = "#{API_BASE_URL}/ratings/#{params[:id]}/edit.json"
	    payload = params.to_json(:only => [:rating])
	    rest_resource = RestClient::Resource.new(uri)
	    begin
	      rest_resource.put payload , :content_type => "application/json"
	      flash[:notice] = "Rating updated successfully"
	    rescue Exception => e
	      flash[:error] = "Raiting failed to update"
	    end
	    redirect_to root_path
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
	    redirect_to root_path
	end
	 
end
