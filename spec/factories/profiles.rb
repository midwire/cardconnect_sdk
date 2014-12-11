FactoryGirl.define do
  factory :profile_request, class: CardconnectSdk::Profile::Request do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    profileid nil
    acctid nil
  end

  factory :create_profile_request, class: CardconnectSdk::Profile::CreateUpdateRequest do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    name 'TOM JONES'
    street '123 MAIN STREET'
    city 'MIDVALE'
    region 'UT'
    country 'US'
    postal '84047'
    phone '8015551212'
    email 'tom.jones@example.com'

    trait :visa do
      accttype 'VISA'
      account '4111111111111111'
      expiry '1215' # MMYY
    end

    trait :echeck do
      account '123123123123'
      bankaba '124001545' # Chase Bank, UT
      ssnl4 '7890'
      license 'UT:98989898'
    end

    trait :default do
      defaultacct 'Y'
    end

    trait :update do
      profileupdate 'Y'
    end

  end

  factory :delete_profile_request, class: CardconnectSdk::Profile::DeleteRequest do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    profileid nil
    acctid nil
  end

end
