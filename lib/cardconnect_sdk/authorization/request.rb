module CardconnectSdk
  module Authorization
    class Request

      attr_accessor :merchid, :accttype, :orderid, :account, :expiry, 
                    :amount, :currency, :name, :address, :city, :region, :country, :postal,
                    :ecomind, :cvv2, :track, :tokenize

      def valid?
        !merchid.nil?
      end
      
    end
  end
end
