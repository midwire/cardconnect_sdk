require 'spec_helper'

module CardconnectSdk
  module SettlementStatus
    RSpec.describe Request, type: :lib do
      context '.initialize' do
        it 'instantiates the right class' do
          expect(Request.new).to be_a(described_class)
        end

        context 'status for date' do
          it 'has the expected attributes' do
            req = described_class.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], date: '1208')
            expect(req.merchid).to eq(ENV['CARDCONNECT_MERCHANT_ID'])
            expect(req.date).to eq('1208')
            expect(req.batchid).to be_empty
          end

          context '.to_json' do
            it 'returns valid json' do
              req = described_class.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], date: '1208')
              json = req.to_json
              expect(json).to eq(
                                  '{"merchid":"496160873888","date":"1208"}'
                              )
            end
          end
        end

        context 'status for specific batch' do
          it 'can request status for a batch' do
            req = described_class.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], batchid: 'abc123')
            expect(req.merchid).to eq(ENV['CARDCONNECT_MERCHANT_ID'])
            expect(req.batchid).to eq('abc123')
            expect(req.date).to be_empty
          end

          context '.to_json' do
            it 'returns valid json' do
              req = described_class.new(merchid: ENV['CARDCONNECT_MERCHANT_ID'], batchid: 'abc123')
              json = req.to_json
              expect(json).to eq(
                                  '{"merchid":"496160873888","batchid":"abc123"}'
                              )
            end
          end
        end
      end
    end
  end
end