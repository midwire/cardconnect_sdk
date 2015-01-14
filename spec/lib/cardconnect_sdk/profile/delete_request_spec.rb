require 'spec_helper'

module CardconnectSdk
  module Profile
    RSpec.describe DeleteRequest, type: :lib do
      context '.initialize' do
        it 'instantiates the right class' do
          expect(DeleteRequest.new).to be_a(described_class)
        end

        it 'has the expected attributes' do
          req = FactoryGirl.create(:delete_profile_request, profileid: '1234567890', acctid: '1')
          expect(req.merchid).to eq(ENV['CARDCONNECT_MERCHANT_ID'])
          expect(req.profileid).to eq('1234567890')
          expect(req.acctid).to eq('1')
        end
      end

      context '.to_json' do
        it 'returns valid json' do
          req = FactoryGirl.create(:delete_profile_request, profileid: '1234567890', acctid: '1')
          json = req.to_json
          expect(json).to eq(
            '{"merchid":"496160873888","profileid":"1234567890","acctid":"1"}'
          )
        end
      end
    end
  end
end
