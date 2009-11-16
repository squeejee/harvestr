require File.dirname(__FILE__) + '/../test_helper'

class ReportsTest < Test::Unit::TestCase
  include Harvest
  
  context "When using the TimeTracking API" do
    setup do
      Harvest.domain = 'pengwynn'
      Harvest.email =  'pengwynn@example.com'
      Harvest.password = 'OU812'
      @client = Harvest::Reports.new 
    end

    should "retrieve project entries for a time range as string values" do
      stub_get "http://pengwynn%40example.com:OU812@pengwynn.harvestapp.com/projects/408960/entries?from=20090730&to=20090802", 'project_entries.xml'
      entries = @client.project_entries(408960, '20090730', '20090802')
      entries.size.should == 4
      entries.first.hours.should == 4.5
    end
  end
end