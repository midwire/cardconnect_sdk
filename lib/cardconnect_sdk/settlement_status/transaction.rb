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

      # To get a transaction means it had to have been approved for capture
      def approved?
        true
      end
    end
  end
end
