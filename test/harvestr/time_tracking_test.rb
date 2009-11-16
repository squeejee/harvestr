require File.dirname(__FILE__) + '/../test_helper'

class TimeTrackingTest < Test::Unit::TestCase
  include Harvest
  
  context "When using the TimeTracking API" do
    setup do
      Harvest.domain = 'pengwynn'
      Harvest.email =  'pengwynn@example.com'
      Harvest.password = 'OU812'
      @client = Harvest::TimeTracking.new 
    end

    should "retrieve time entries for today" do
      stub_get "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/daily", 'daily.xml'
      response = @client.daily
      entries = response.day_entries
      entries.size.should == 2
      entries.first.project.should == 'Internal'
    end
    
    should "retrieve time entries for a given day as a string" do
      stub_get "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/daily/213/2009", 'daily.xml'
      response = @client.daily('2009-8-1')
      entries = response.day_entries
      entries.class.should == Array
    end
    
    should "retrieve time entries for a given day as a DateTime" do
      stub_get "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/daily/213/2009", 'daily.xml'
      response = @client.daily(DateTime.parse('2009-08-01'))
      entries = response.day_entries
      entries.class.should == Array
    end
    
    should "retrieve a single entry" do
      stub_get "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/daily/show/14316546", 'entry.xml'
      entry = @client.entry(14316546)
      entry.id.should == 14316546
      entry.client.should == 'Pengwynn Group'
    end
    
    should "toggle the timer" do
      stub_get "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/daily/timer/14319479", 'entry.xml'
      entry = @client.toggle(14319479)
      entry.id.should == 14319479
    end
    
    should "create a new entry" do
      stub_post "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/daily/add", 'entry.xml'
      entry = @client.add({
        :project_id => 408960,
        :task_id => 333865,
        :hours => 3.24,
        :spent_at => Time.now
      })
      entry.id.should == 14316546
    end
    
    # should "delete an entry" do
    #   FakeWeb.register_uri(:delete, "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/delete/14316546", {})
    #   @client.delete(14316546)
    # end
    
    should "update an entry" do
      stub_post "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/daily/update/14316546", 'entry.xml'
      entry = @client.update(14316546, {:notes => 'Writing TPS reports'})
      entry.id.should == 14316546
    end
    
  end
end