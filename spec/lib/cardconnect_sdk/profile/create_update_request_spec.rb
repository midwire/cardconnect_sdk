require 'spec_helper'

module CardconnectSdk
  module Profile
    RSpec.describe CreateUpdateRequest, type: :lib do
      context '.initialize' do
        it 'instantiates the right class' do
          expect(CreateUpdateRequest.new).to be_a(described_class)
        end

        it 'has the expected attributes' do
          req = FactoryGirl.create(:create_profile_request)
          expect(req.merchid).to eq(ENV['CARDCONNECT_MERCHANT_ID'])
        end
      end

      context '.to_json' do
        it 'returns valid json' do
          req = FactoryGirl.create(:create_profile_request)
          json = req.to_json
          expect(json).to eq(
            '{"merchid":"496160873888","name":"TOM JONES","street":"123 MAIN STREET","city":"MIDVALE","region":"UT","country":"US","postal":"84047","phone":"8015551212","email":"tom.jones@example.com"}'
          )
        end
      end
    end
  end
end
