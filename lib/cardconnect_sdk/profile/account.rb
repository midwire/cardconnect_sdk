module CardconnectSdk
  module Profile
    class Account
      include Attributable

      attr_accessor :profileid, :acctid, :accttype, :defaultacct, :respstat, :respcode, :resptext, :respproc,
                    :account, :name, :address, :city, :region, :country, :postal, :phone, :email

      attr_accessor :expiry

      attr_accessor :ssnl4, :license

    end
  end
end

# {
#   "region"=>"UT",
#   "acctid"=>"2",
#   "phone"=>"8015551212",
#   "postal"=>"84047",
#   "accttype"=>"ECHK",
#   "ssnl4"=>"7890",
#   "defaultacct"=>"N",
#   "profileid"=>"14381776143693793026",
#   "city"=>"MIDVALE",
#   "country"=>"US",
#   "token"=>"9124468384113123",
#   "email"=>"tom.jones@example.com",
#   "name"=>"TOM JONES",
#   "license"=>"UT:98989898",
#   "auoptout"=>"N"
# }
