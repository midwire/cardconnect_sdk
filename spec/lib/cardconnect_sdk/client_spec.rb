require 'spec_helper'

module CardconnectSdk
  RSpec.describe Client, type: :lib do

    let(:config) {
      {
        url:      ENV['CARDCONNECT_BASE_URL'],
        username: ENV['CARDCONNECT_USERNAME'], 
        password: ENV['CARDCONNECT_PASSWORD']
      }
    }

    context '.initialize' do
      it 'accepts configuration params' do
        config = { url: 'CC_URL', username: 'CC_USERNAME', password: 'CC_PASSWORD' }
        client = Client.new(config)
        
        expect(client.url).to      eq('CC_URL')
        expect(client.username).to eq('CC_USERNAME')
        expect(client.password).to eq('CC_PASSWORD')
      end

      it 'Base64 encodes username and password' do
        username = 'myusername'
        password = 'password'
        auth_token = Base64.strict_encode64("#{username}:#{password}")

        client = Client.new({ username: username, password: password })

        # testing a private method using #send
        expect(client.send(:auth_token)).to eq(auth_token)
      end
    end

    context '.ping' do
      it 'establishes an authorized connection to the CardConnect REST API' do
        client = Client.new(config)
        expect(client.ping).to match(/CardConnect REST Servlet/)
      end
    end

  end
end
