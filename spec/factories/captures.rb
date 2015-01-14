FactoryGirl.define do
  factory :capture_request, class: CardconnectSdk::Capture::Request do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    retref nil
    authcode nil
    amount '0.99'
  end
end
