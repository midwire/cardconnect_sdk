require 'spec_helper'

module CardconnectSdk
  module SettlementStatus
    RSpec.describe Transaction, type: :lib do
      let(:instance) { described_class.new }

      context '.settled?' do
        context "#when setlstat == 'Y'" do
          let(:instance) { described_class.new(setlstat: 'Y') }

          it { expect(instance).to be_settled }
          it { expect(instance).to be_card_bank_accepted }
        end

        context "#when setlstat == 'N'" do
          let(:instance) { described_class.new(setlstat: 'N') }

          it { expect(instance).to be_settled }
          it { expect(instance).to_not be_card_bank_accepted }
        end

        context "#when setlstat != 'Y' or 'N'" do
          let(:instance) { described_class.new(setlstat: 'R') }
          
          it { expect(instance).to_not be_settled }
          it { expect(instance).to_not be_card_bank_accepted }
        end
      end

    end
  end
end
