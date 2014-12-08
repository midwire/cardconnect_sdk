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

      context '.to_json' do
        it 'returns valid json' do
          req = create(:visa_authorization_request)
          json = req.to_json
          expect(json).to eq(
            '{"merchid":"496160873888","accttype":"VISA","orderid":"CCSDK-2014-12-25","account":"4111111111111111","amount":"0","currency":"USD","name":"TOM JONES","address":"123 MAIN STREET","city":"MIDVALE","region":"UT","country":"US","postal":"84047","ecomind":"E","expiry":"1215","cvv2":"123"}'
          )
        end
      end
    end
  end
end
