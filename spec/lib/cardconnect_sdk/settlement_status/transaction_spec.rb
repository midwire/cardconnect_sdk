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

      context '.approved?' do
        let(:instance) { described_class.new }

        it 'should always be approved' do
          expect(instance).to be_approved
        end
      end

      context '.declined?' do
        let(:instance) { described_class.new }

        it 'should never be declined' do
          expect(instance).to_not be_declined
        end
      end

    end
  end
end
