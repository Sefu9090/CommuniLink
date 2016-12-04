require './config/environment'
require './app/models/api.rb'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end
  
  NUMBER_OF_EVENTS = 12

  get '/' do
    @numberOfEvents = NUMBER_OF_EVENTS
    # @tweets = Tweet.all
    # @users = User.all
    erb :index
  end

  # get '/tweet' do
  #   erb :tweet
  #   if session[:user_id] #returns nil if there isn't one
  #     erb :tweet
  #   else
  #     redirect "/"
  #   end
  # end

  # post '/tweet' do
  #   user = User.find_by(:id => session[:user_id])
  #   tweet = Tweet.new(:user => user, :status => params[:status])
  #   tweet.save
  #   redirect '/'
  # end

  get '/users' do
    # @users = User.all
    erb :users
  end

  post '/sign-up' do 
    # @user = User.new(:username => params[:username], :email => params[:email])
    # @user.save
    redirect '/login'
  end
  
  
  get '/login' do
    erb :login
  end
  
  get "/openDataEvents" do
    @numberOfEvents = NUMBER_OF_EVENTS
    @results = getData 
    erb :openDataEvents 
  end
  
  get "/about" do
    erb :about
  end
  
  post '/openDataEvents' do
    @numberOfEvents = NUMBER_OF_EVENTS
    @results = getData
    puts params
    puts "event name is "
    newEvent = {
      "event_name" => params[:event_name],
      "event_date_time_start" => params[:event_date_time_start],
      "type_of_event" => params[:type_of_event],
      "subject_matter" => params[:subject_matter],
      "information_website" => params[:information_website]
    }
    @results.unshift(newEvent)
    erb :openDataEvents
  end
  
  post "/openDataEventsAdd" do
    @results = getData 
    NUMBER_OF_EVENTS += 12
    @numberOfEvents = NUMBER_OF_EVENTS
    erb :openDataEvents 
  end  
  
  
  post '/login' do
    # user = User.find_by(:username => params[:username])
    # if user
    #     session[:user_id] = user.id
    #     redirect "/"
    # else
    #     redirect "/users"
    # end
  end

  get '/logout' do
    session.destroy
    redirect '/'
  end
  
  get "/results"  do
    @giphyResults = ask_for_data_from_giphy("community")
    erb :results
  end
    
    
  helpers do
    def logged_in?
      session[:user_id]
    end
    
    def current_user
      # User.find(session[:user_id])
    end
  end
end

