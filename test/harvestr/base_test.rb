require File.dirname(__FILE__) + '/../test_helper'

class BaseTest < Test::Unit::TestCase
  include Harvest
  
  context "When using the API" do
    setup do
      Harvest.domain = 'pengwynn'
      Harvest.email =  'pengwynn@example.com'
      Harvest.password = 'OU812'
      @client = Harvest::Base.new 
    end
    
    should "fetch rate limit status" do
      stub_get "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/account/rate_limit_status", 'rate_limit_status.xml'
      status = @client.rate_limit_status
      status.max_calls.should == 40
      status.lockout_seconds.should == 300
    end
    
  end
end