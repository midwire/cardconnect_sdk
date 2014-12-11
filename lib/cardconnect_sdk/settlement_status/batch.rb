module CardconnectSdk
  module SettlementStatus
    class Batch
      include Attributable

      attr_reader :batchid, :hoststat, :hostbatch, :merchid, :respproc

      attr_reader :txns

      def initialize(attrs={})
        attrs.symbolize_keys!
        txns = attrs.delete(:txns)

        super(attrs)

        unpack_txns(txns)
      end

      private

      def unpack_txns(txns=[])
        @txns = txns.map { |tx| Transaction.new(tx) }
      end

    end
  end
end
