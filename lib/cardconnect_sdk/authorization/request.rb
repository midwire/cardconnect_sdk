module CardconnectSdk
  module Authorization
    class Request
      include Attributable

      # Standard Attributes for all authorizations
      attr_accessor :merchid, :accttype, :orderid, :account, :amount, :currency,
                    :name, :address, :city, :region, :country, :postal, :email,
                    :ecomind, :tokenize, :capture

      # Credit Card Attributes
      attr_accessor :expiry, :cvv2, :track

      # ECheck/ACH Attributes
      attr_accessor :bankaba, :ssnl4, :license

      # TODO: implement user fields
      def userfields
        @userfields ||= {}
      end
    end
  end
end
