module CardconnectSdk
  module Profile
    class CreateUpdateResponse
      include Attributable

      # Standard Attributes for profiles
      attr_reader :profileid, :acctid, :accttype, :defaultacct, :token,
                  :respstat, :resptext, :respcode, :respproc

      attr_reader :name, :address, :city, :region, :country, :postal,
                  :phone, :email

      # Credit Card Attributes
      attr_reader :expiry

      # ECheck/ACH Attributes
      attr_reader :bankaba, :ssnl4, :license

    end
  end
end

# {
#   "region": "AK",
#   "phone": "7778789999",
#   "accttype": "VISA",
#   "postal": "19090",
#   "ssnl4": "3655",
#   "respproc": "PPS",
#   "expiry": "0214",
#   "city": "ANYTOWN",
#   "country": "US",
#   "resptext": "Profile Saved",
#   "token": "9440670166031111",
#   "respcode": "09",
#   "address": "123 MAIN STREET",
#   "name": "TOM JONES",
#   "license": "123451254",
#   "respstat": "A",
#   "profileid": "12345678901234567890",
#   "acctid": "1"
# }
