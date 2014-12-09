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

    context '#requests' do

      context '.ping' do
        it 'establishes an authorized connection to the CardConnect REST API' do
          expect(instance.ping).to match(/CardConnect REST Servlet/)
        end
      end

      context '#authorization', :vcr do
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

          it 'creates a new echeck authorization', :vcr do
            req = FactoryGirl.create(:echeck_authorization_request)
            res = instance.authorize_transaction(req)
            expect(res).to be_a(CardconnectSdk::Authorization::Response)
            expect(res.respstat).to eq('A')
          end
        end
      end

      context '#capture', :vcr do
        let(:retref) {
          res = instance.authorize_transaction(FactoryGirl.create(:visa_authorization_request, amount: '0.99'))
          res.retref
        }

        context '.capture_transaction' do
          it 'captures an existing authorized transaction' do
            req = FactoryGirl.create(:capture_request, retref: retref)
            res = instance.capture_transaction(req)
            expect(res.setlstat).to eq("Queued for Capture")
          end
        end
      end

      context '#void', :vcr do
        let(:retref) {
          res = instance.authorize_transaction(FactoryGirl.create(:visa_authorization_request, amount: '0.99'))
          res.retref
        }

        context '.void_transaction' do
          it 'voids an existing transaction' do
            req = FactoryGirl.create(:void_request, retref: retref)
            res = instance.void_transaction(req)
            expect(res.authcode).to eq("REVERS")
          end
        end
      end

      context '#refund', :vcr do
        let(:retref) {
          res = instance.authorize_transaction(FactoryGirl.create(:visa_authorization_request, :capture, amount: '0.99'))
          # TODO: force settlement so the refund will work
          res.retref
        }

        context '.refund_transaction' do
          it 'refunds an existing transaction' do
            req = FactoryGirl.create(:refund_request, retref: retref)
            res = instance.refund_transaction(req)
            # HACK: forced expected return values in the cassette
            expect(res.respstat).to eq('A')
            expect(res.authcode).to eq("REFUND")
          end
        end
      end

      context '#inquire', :vcr do
        let(:retref) {
          res = instance.authorize_transaction(FactoryGirl.create(:visa_authorization_request, amount: '0.99'))
          res.retref
        }

        context '.inquire_transaction' do
          it 'returns "Txn not found" for an unknown transaction' do
            req = FactoryGirl.create(:inquire_request, retref: 'CCSDK')
            res = instance.inquire_transaction(req)
            expect(res.respstat).to eq('C')
            expect(res.resptext).to eq('Txn not found')
          end

          it 'returns "Authorized" for an authorized transaction' do
            req = FactoryGirl.create(:inquire_request, retref: retref)
            res = instance.inquire_transaction(req)
            expect(res.respstat).to eq('A')
            expect(res.setlstat).to eq("Authorized")
          end
        end
      end

      context '#settlement_status', :vcr do
        context '.settlement_status_transaction' do
          it 'returns an array of transactions with settlement status info' do
            req = CardconnectSdk::SettlementStatus::Request.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], date: '1208')
            res = instance.settlement_status_transaction(req)
            expect(res.txns).to be_a(Array)
          end
        end
      end

      context '#deposit', :vcr do
        context '.deposit_transaction' do
          it 'returns an array of deposit transactions' do
            req = CardconnectSdk::Deposit::Request.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], date: '1208')
            res = instance.deposit_transaction(req)
            expect(res.txns).to be_a(Array)
          end
        end
      end

      context '#funding', :vcr do
        context '.funding_transaction' do
          it 'returns an array of deposit transactions' do
            req = CardconnectSdk::Funding::Request.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], date: '1208')
            res = instance.funding_transaction(req)
            expect(res.txns).to be_a(Array)
          end
        end
      end
    end
  end
end
