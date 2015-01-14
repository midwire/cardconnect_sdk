require 'spec_helper'

RSpec.describe CardconnectSdk, type: :lib do

  context '#root' do
    it 'returns a Pathname instance' do
      expect(CardconnectSdk.root).to be_a(Pathname)
    end

    it 'returns the root directory' do
      dir = CardconnectSdk.root
      expect(dir.to_s).to match(/cardconnect_sdk$/)
      expect(File.exist?(CardconnectSdk.root)).to eq(true)
    end
  end

end
