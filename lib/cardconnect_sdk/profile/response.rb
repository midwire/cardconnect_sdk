module CardconnectSdk
  module Profile
    class Response
      include Attributable

      attr_reader :profileid, :accounts

      def initialize(accounts=[])
        @accounts = []
        accounts.each do |account|
          @accounts << Account.new(account.deep_symbolize_keys)
        end
      end

      def profileid
        @profileid ||= accounts.first.profileid rescue ''
      end

      # Overridden because the json returns an array instead of
      # a typical hash, so deep_stringify_keys would fail.
      def self.from_json(json)
        self.new(JSON.parse(json))
      end
    end
  end
end

# [
#   {
#     "region": "AK",
#     "phone": "7778789999",
#     "postal": "19090",
#     "address": "123 MAIN STREET",
#     "accttype": "VISA",
#     "token": "9440670166031111",
#     "ssnl4": "3655",
#     "name": "TOM JONES",
#     "license": "123451254",
#     "country": "US",
#     "city": "ANYTOWN",
#     "expiry": "0214",
#     "profileid": "12345678901234567890",
#     "acctid": "1"
#   }
# ]
