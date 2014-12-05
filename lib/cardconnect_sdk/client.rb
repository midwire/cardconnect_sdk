require 'base64'

module CardconnectSdk
  class Client
    def initialize(username = ENV['CARDCONNECT_USERNAME'],
                   password = ENV['CARDCONNECT_PASSWORD'])
      @auth_token = Base64.strict_encode64("#{username}:#{password}")
    end

    private

    def auth_token
      @auth_token
    end
  end
end
