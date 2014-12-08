FactoryGirl.define do

  factory :visa_authorization_request, class: CardconnectSdk::Authorization::Request do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    accttype 'VISA'
    orderid 'CCSDK-2014-12-25'
    account '4111111111111111'
    expiry '1215' # MMYY
    amount '0' # verification request
    currency 'USD'
    name 'TOM JONES'
    address '123 MAIN STREET'
    city 'MIDVALE'
    region 'UT'
    country 'US'
    postal '84047'
    ecomind 'E' # T telephone or mail, R recurring, E ecommerce/Internet
    cvv2 '123'
    track nil
    
    trait :tokenize do
      tokenize 'Y'
    end

    trait :capture do
      capture 'Y'
    end
  end

  factory :echeck_authorization_request, class: CardconnectSdk::Authorization::Request do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    account '123123123123'
    bankaba '124001545' # Chase Bank, UT
    amount '100.00'
    currency 'USD'
    name 'TOM JONES'
    ecomind 'E'
    
    trait :tokenize do
      tokenize 'Y'
    end

    trait :capture do
      capture 'Y'
    end
  end

end
