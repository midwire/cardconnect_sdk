require 'spec_helper'

module CardconnectSdk
  module Capture
    RSpec.describe Response, type: :lib do
      it_behaves_like 'approved, retry, or declined'

      it 'has a batch id' do
        capture = described_class.new(respstat: 'A', batchid: '1234')
        expect(capture.batchid).to_not be_empty
      end

      it 'has not settled' do
        expect(described_class.new).to_not be_settled
      end
    end
  end
end