require 'sinatra'
require 'twitter'
require 'haml'

class TwitterInfo < Sinatra::Application

  set :views, settings.root + '/../views'

  get '/' do
    haml :index
  end

  get '/user/:username' do

    @user = params[:username]
	begin
      user_id = Twitter.user(@user).id
      followers = Twitter.follower_ids(user_id).ids
      @num_followers = followers.length

      haml :followers
    # help from Scott S to work around library + Twitter issues
	rescue Twitter::BadRequest => e
	  @num_followers = 50
	  haml :followers
	rescue Twitter::NotFound => e
	  status 404
	  haml :my404
	end  
  end

  post // do
    halt 500, 'Whoa. Sorry. No POSTs allowed.'
  end

end