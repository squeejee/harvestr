module Harvest
  class Base
    include HTTParty
    format :xml
    headers({'Accept' => 'text/xml'})
  
    attr_accessor :domain, :email, :password, :use_ssl
  
    def initialize(options={})
      @domain = options[:domain] ||= Harvest.domain
      @email = options[:email] ||= Harvest.email
      @password = options[:password] ||= Harvest.password
      @use_ssl = options[:use_ssl] ||= Harvest.use_ssl
      
      self.class.base_uri "#{@domain}.harvestapp.com"
      self.class.basic_auth(@email, @password)
    end
    
    def rate_limit_status
      request = Mash.new(self.class.get('/account/rate_limit_status')).request
      %w(count time_frame_limit max_calls lockout_seconds).each do |key|
        request[key] = request[key].to_i
      end
      request
    end
    
    
  end
end