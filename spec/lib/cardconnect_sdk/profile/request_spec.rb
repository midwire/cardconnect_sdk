require 'spec_helper'

module CardconnectSdk
  module Profile
    RSpec.describe Request, type: :lib do
      context '.initialize' do
        it 'instantiates the right class' do
          expect(Request.new).to be_a(described_class)
        end

        it 'has the expected attributes' do
          req = FactoryGirl.create(:profile_request)
          expect(req.merchid).to eq(ENV['CARDCONNECT_MERCHANT_ID'])
        end
      end

      context '.to_json' do
        it 'returns valid json' do
          req = FactoryGirl.create(:profile_request)
          json = req.to_json
          expect(json).to eq(
            '{"merchid":"496160873888"}'
          )
        end
      end
    end
  end
end
