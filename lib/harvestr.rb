require 'forwardable'
require 'rubygems'

gem 'mash', '0.0.3'
require 'mash'

gem 'httparty', '0.4.3'
require 'httparty'

class APIKeyNotSet   < StandardError; end

module Harvest
  
  def self.domain=(value)
    @domain = value
  end
  
  def self.domain
    @domain
  end
  
  def self.email=(value)
    @email = value
  end
  
  def self.email
    @email
  end
  
  def self.password=(value)
    @password = value
  end
  
  def self.password
    @password
  end
  
  def self.use_ssl=(value)
    @use_ssl = !!value
  end
  
  def self.use_ssl
    @use_ssl ||= false
  end
  
  def self.default_options
    {
      :domain => @domain,
      :email => @email,
      :password => @password,
      :use_ssl => @use_ssl
    }
  end
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'harvest', 'base')
require File.join(directory, 'harvest', 'time_tracking')
require File.join(directory, 'harvest', 'reports')