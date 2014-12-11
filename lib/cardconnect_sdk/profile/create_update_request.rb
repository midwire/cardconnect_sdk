module CardconnectSdk
  module Profile
    class CreateUpdateRequest
      include Attributable

      # Standard Attributes for creating/updating profiles
      attr_accessor :merchid, :profile, :defaultacct, :profileupdate, :accttype, :account,
                    :name, :street, :city, :region, :country, :postal, :phone, :email

      # Credit Card Attributes
      attr_accessor :expiry

      # BCheck/ACH Attributes
      attr_accessor :bankaba, :ssnl4, :license
      
    end
  end
end
