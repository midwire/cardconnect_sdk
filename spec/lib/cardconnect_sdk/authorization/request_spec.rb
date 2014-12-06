require 'spec_helper'

module CardconnectSdk
  module Authorization
    RSpec.describe Request, type: :lib do
      context '.initialize' do
        it 'instantiates the right class' do
          expect(Request.new).to be_a(described_class)
        end

        it 'has the expected attributes' do
          req = create(:visa_authorization_request)
          expect(req.merchid).to eq(ENV['CARDCONNECT_MERCHANT_ID'])
        end
      end

      context '.validation' do
        it 'requires merchid' do
          req = create(:visa_authorization_request, merchid: nil)
          expect(req).not_to be_valid
        end

        it 'requires account' do

        end
      end
    end
  end
end
