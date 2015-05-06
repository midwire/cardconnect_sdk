require 'spec_helper'

module CardconnectSdk
  module SettlementStatus
    RSpec.describe Response, type: :lib do
     settlement_json_response =  <<-SETTLEMENT_JSON
[
  {
    "txns": [
      {
        "setlstat": "N",
        "retref": "179001161341"
      },
      {
        "setlstat": "Y",
        "retref": "179002161341"
      }
    ],
    "batchid": "71742042",
    "hoststat": "GB",
    "hostbatch": "71742041"
  }
]
      SETTLEMENT_JSON

      context '.from_json' do
        it 'handles proper json' do
          response = described_class.from_json(settlement_json_response)
          expect(response.batches).to be_an(Array)
          expect(response.batches.count).to eql(1)
        end

        it 'handles no results' do
          response = described_class.from_json('Null batches')
          expect(response.batches).to be_an(Array)
          expect(response.batches).to be_empty
        end
      end

    end
  end
end