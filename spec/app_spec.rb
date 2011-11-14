require 'app'
require 'rspec'
require 'rack/test'

set :environment, :test

describe "Twitter Info" do
  include Rack::Test::Methods

  def app
    TwitterInfo
  end

  it "should provide helpful instructions" do

    get "/"

    last_response.body.should match(/Append a twitter username on the url to display/)
    last_response.status.should == 200

  end

  it "should return a 500 status for any POST" do

    post "/user/burtlo"

    last_response.status.should == 500
    last_response.body.should match(/Sorry/)

  end


  ##
  # this spec needs to be written.
  #
  it "should display the user's follower count for any valid username" do
    
	get "/user/burtlo"
	
	last_response.status.should == 200
	# the response body includes the number of followers, but how do i extract
	# it and then test it?
	# get the response body, parse it for my "number of followers: x" and pull
	# out the x, then compare to should be_within?
	# this doesn't quite work- i forgot the whole body is returned.
	# would need to loop though body line by line looking for "Number of..." 
	# and then pull that out plus ditch anything between <>.  this seems like
	# its too complicated for a test...
	#num_followers =	last_response.body.delete("Number of Followers: ")
	#puts num_followers
	#num_followers.to_i.should be_within(1000,0)
	
	# this is the simple way out- just look for the current num of users for 
	# burtlo as of 11/13/2011
	last_response.body.should match(/77/)
  end	


  ##
  # this spec is a placeholder a feature that needs to be written.
  # please write the spec and the feature.
  # gold star for writing the spec before the lib code. :)
  #
  # hints:
  # use a begin/rescue/end block to rescue the error raised by
  # the Twitter gem when a username cannot be found.
  #
  # when that happens, return a new template file named 404.haml
  #
  it "should return a custom 404 page when the username cannot be found" do
  
    get "/user/jseryapdj377"
	
	last_response.status.should == 404
	last_response.body.should match(/my custom 404/) 
  end


end
