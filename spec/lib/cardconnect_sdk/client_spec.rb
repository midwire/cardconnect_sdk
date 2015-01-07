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
          it 'returns a CardconnectSdk::Authorization::Response' do
            req = FactoryGirl.create(:visa_authorization_request)
            res = instance.authorize_transaction(req)
            expect(res).to be_a(CardconnectSdk::Authorization::Response)
          end

          it 'creates a new credit card authorization' do
            req = FactoryGirl.create(:visa_authorization_request)
            res = instance.authorize_transaction(req)
            expect(res).to be_approved
          end

          it 'creates a new tokenized credit card authorization' do
            req = FactoryGirl.create(:visa_authorization_request, :tokenize)
            res = instance.authorize_transaction(req)
            expect(res.token).to_not be_nil
          end

          it 'creates a new capture credit card authorization' do
            req = FactoryGirl.create(:visa_authorization_request, :capture, amount: '99.99')
            res = instance.authorize_transaction(req)
            expect(res).to be_approved
            expect(res.authcode).to_not be_nil
          end

          it 'creates a new echeck authorization' do
            req = FactoryGirl.create(:echeck_authorization_request)
            res = instance.authorize_transaction(req)
            expect(res).to be_approved
          end

          context '#with a profile' do
            let(:profile) do
              req = FactoryGirl.create(:create_profile_request, :visa)
              instance.create_profile(req)
            end

            it 'creates a new authorization' do
              req = FactoryGirl.create(:profile_authorization_request, :capture, 
                profile: "#{profile.profileid}/#{profile.acctid}" )
              res = instance.authorize_transaction(req)
              expect(res).to be_approved
            end
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
            expect(res).to be_approved
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
            expect(res).to be_declined
            expect(res.resptext).to eq('Txn not found')
          end

          it 'returns "Authorized" for an authorized transaction' do
            req = FactoryGirl.create(:inquire_request, retref: retref)
            res = instance.inquire_transaction(req)
            expect(res).to be_approved
            expect(res.setlstat).to eq("Authorized")
          end
        end
      end

      context '#settlement_status', :vcr do
        context '.settlement_status_transaction' do
          it 'returns an array of transactions with settlement status info' do
            req = CardconnectSdk::SettlementStatus::Request.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], date: '1208')
            res = instance.settlement_status_transaction(req)
            expect(res.batches).to be_a(Array)

            batch = res.batches.first
            expect(batch).to be_a(CardconnectSdk::SettlementStatus::Batch)

            txn = batch.txns.first
            expect(txn).to be_a(CardconnectSdk::SettlementStatus::Transaction)
          end
        end
      end

      context '#deposit', :vcr do
        context '.deposit_transaction' do
          it 'returns an array of deposit transactions' do
            req = CardconnectSdk::Deposit::Request.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], date: '1208')
            res = instance.deposit_transaction(req)
            expect(res.deposits).to be_a(Array)

            deposit = res.deposits.first
            expect(deposit).to be_a(CardconnectSdk::Deposit::AchDeposit)

            txn = deposit.txns.first
            expect(txn).to be_a(CardconnectSdk::Deposit::Transaction)
          end
        end
      end

      context '#funding', :vcr do
        context '.funding_transaction' do
          it 'returns an array of funding transactions' do
            req = CardconnectSdk::Funding::Request.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], date: '1208')
            res = instance.funding_transaction(req)
            
            expect(res.txns).to be_a(Array)            
            txn = res.txns.first
            expect(txn).to be_a(CardconnectSdk::Funding::Transaction)

            expect(res.fundings).to be_a(Array)
            funding = res.fundings.first
            expect(funding).to be_a(CardconnectSdk::Funding::FundingNode)

            expect(res.adjustments).to be_a(Array)
            adjustment = res.adjustments.first
            expect(adjustment).to be_a(CardconnectSdk::Funding::Adjustment)
          end
        end
      end

      context '#profile', :vcr do
        context '.create_profile' do
          it 'creates a new profile with a credit card account' do
            req = FactoryGirl.create(:create_profile_request, :visa)
            res = instance.create_profile(req)
            expect(res).to be_approved
            expect(res.profileid).to match(/^[0-9]+$/)
            expect(res.accttype).to eq('VISA')
          end

          it 'creates a new profile with an echeck account' do
            req = FactoryGirl.create(:create_profile_request, :echeck)
            res = instance.create_profile(req)
            expect(res).to be_approved
            expect(res.profileid).to match(/^[0-9]+$/)
            expect(res.accttype).to eq('ECHK')
          end
        end

        context '.get_profile', :vcr do
          let(:profileid) {
            # create a profile with a cc and echeck account
            req = FactoryGirl.create(:create_profile_request, :visa)
            res = instance.create_profile(req)
            profileid = res.profileid

            req = FactoryGirl.create(:create_profile_request, :echeck, profile: profileid)
            res = instance.create_profile(req)
            profileid = res.profileid
          }

          it 'returns an existing profile with multiple accounts' do
            req = FactoryGirl.create(:profile_request, profileid: profileid)
            res = instance.get_profile(req)
            expect(res.accounts.size).to eq(2)
          end

          it 'returns a specific account within a profile' do
            req = FactoryGirl.create(:profile_request, profileid: profileid, acctid: '1')
            res = instance.get_profile(req)
            expect(res.accounts.size).to eq(1)
            expect(res.accounts.first.acctid).to eq('1')
          end

        end

        context '.update_profile' do
          let(:profile) {
            # create a profile with an echeck account
            req = FactoryGirl.create(:create_profile_request, :echeck)
            res = instance.create_profile(req)            
          }

          it 'updates an existing profile' do
            req = FactoryGirl.create(:create_profile_request, :update, 
              profile: "#{profile.profileid}/#{profile.acctid}", 
              name: 'TOMMY JONES', phone: '8015551234')
            res = instance.update_profile(req)
            expect(res).to be_approved
            expect(res.name).to eq('TOMMY JONES')
            expect(res.phone).to eq('8015551234')
          end
        end

        context '.delete_profile' do
          let(:profile) {
            req = FactoryGirl.create(:create_profile_request, :visa)
            res = instance.create_profile(req)
            profileid = res.profileid

            req = FactoryGirl.create(:create_profile_request, :echeck, profile: profileid)
            res = instance.create_profile(req)        

            profile = instance.get_profile(FactoryGirl.create(:profile_request, profileid: profileid))              
          }

          it 'deletes an existing profile with multiple accounts' do
            req = FactoryGirl.create(:delete_profile_request, 
              profileid: profile.profileid)
            res = instance.delete_profile(req)
            expect(res).to be_approved
            expect(res.respcode).to eq('08')
          end

          it 'deletes a non-default account from an existing profile' do
            non_default_acctid = profile.accounts.detect { |a| a.defaultacct == 'N' }.acctid

            req = FactoryGirl.create(:delete_profile_request, 
              profileid: profile.profileid, acctid: non_default_acctid)
            res = instance.delete_profile(req)
            expect(res).to be_approved
            expect(res.respcode).to eq('08')

            # requery the profile to ensure only the 1 account was deleted
            req = FactoryGirl.create(:profile_request, profileid: profile.profileid)
            res = instance.get_profile(req)
            expect(res.accounts.size).to eq(1)
            expect(res.accounts.first.acctid).to_not eq(non_default_acctid)
          end

          it 'fails to delete a default account from an existing profile' do
            default_acctid = profile.accounts.detect { |a| a.defaultacct == 'Y' }.acctid

            req = FactoryGirl.create(:delete_profile_request, 
              profileid: profile.profileid, acctid: default_acctid)
            res = instance.delete_profile(req)
            expect(res).to be_declined
            expect(res.respcode).to eq('34') # Invalid field
          end
        end
      end
    end
  end
end
