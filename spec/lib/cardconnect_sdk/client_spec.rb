require 'spec_helper'

module CardconnectSdk
  RSpec.describe Client, type: :lib do

    let(:instance) { described_class.new(config) }
    let(:config) {
      {
        url:          ENV['CARDCONNECT_BASE_URL'],
        merchant_id:  ENV['CARDCONNECT_MERCHANT_ID'],
        username:     ENV['CARDCONNECT_USERNAME'], 
        password:     ENV['CARDCONNECT_PASSWORD']
      }
    }

    context '.initialize' do
      it 'accepts configuration params' do
        config = { url: 'CC_URL', merchant_id: 'CC_MERCHANT_ID', username: 'CC_USERNAME', password: 'CC_PASSWORD' }
        client = Client.new(config)
        
        expect(client.url).to         eq('CC_URL')
        expect(client.merchant_id).to eq('CC_MERCHANT_ID')
        expect(client.username).to    eq('CC_USERNAME')
        expect(client.password).to    eq('CC_PASSWORD')
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
    context '#requests' do

      context '.ping' do
        it 'establishes an authorized connection to the CardConnect REST API' do
          expect(instance.ping).to match(/CardConnect REST Servlet/)
        end
      end

      context '#authorization' do
        context '.authorize_transaction' do
          it 'creates a new credit card authorization' do
            req = FactoryGirl.create(:visa_authorization_request)
            res = instance.authorize_transaction(req)
            expect(res).to be_a(CardconnectSdk::Authorization::Response)
            expect(res.respstat).to eq('A')
          end

          it 'creates a new tokenized credit card authorization' do
            req = FactoryGirl.create(:visa_authorization_request, :tokenize)
            res = instance.authorize_transaction(req)
            expect(res.token).to_not be_nil
          end

          it 'creates a new capture credit card authorization' do
            req = FactoryGirl.create(:visa_authorization_request, :capture, amount: '99.99')
            res = instance.authorize_transaction(req)
            expect(res.respstat).to eq('A')
          end

          it 'creates a new echeck authorization' do
            req = FactoryGirl.create(:echeck_authorization_request)
            res = instance.authorize_transaction(req)
            # binding.pry
            expect(res).to be_a(CardconnectSdk::Authorization::Response)
            expect(res.respstat).to eq('A'), "expected: \"A\"\ngot: \"#{res.respstat}\"\nreason: \"#{res.resptext}\""
            # TODO: Figure out what 'Velocity amount' means; maybe need to randomize account or amount
          end
        end
      end
    end

  end
end
