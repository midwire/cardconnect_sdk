require 'spec_helper'

module CardconnectSdk
  RSpec.describe Client, type: :lib do

    context '.initialize' do
      it 'Base64 encodes username and password' do
        username = 'myusername'
        password = 'password'
        auth_token = Base64.strict_encode64("#{username}:#{password}")

        client = Client.new(username, password)
        expect(client.send(:auth_token)).to eq(auth_token)
      end
    end

  end
end
