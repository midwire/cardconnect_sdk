module CardconnectSdk
  module SettlementStatus
    class Transaction
      include Attributable

      attr_reader :setlstat, :retref
      
      def settled?
        setlstat == 'Y' || setlstat == 'N'
      end

      def card_bank_accepted?
        setlstat == 'Y'
      end
    end
  end
end
