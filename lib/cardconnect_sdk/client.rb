require 'base64'
require 'rest_client'

module CardconnectSdk
  class Client

    attr_reader :url, :username, :password

    def initialize(config={})
      @url, @username, @password = config.values_at(:url, :username, :password)
      @auth_token = Base64.strict_encode64("#{@username}:#{@password}")
    end

    def ping
      url = ENV['CARDCONNECT_BASE_URL'] or raise "CARDCONNECT_BASE_URL is not properly configured"
      response = RestClient::Request.new(
        :method => :get,
        :url => url,
        :headers => { 
          :authorization => "Basic #{auth_token}",
          :accept => 'text/html',
          :content_type => 'text/html' 
        }
      ).execute
      
      response.body
    end

    private

    def auth_token
      @auth_token
    end
  end
end
