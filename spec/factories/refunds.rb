FactoryGirl.define do
  factory :refund_request, class: CardconnectSdk::Refund::Request do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    retref nil
    amount '0.99'
  end
end
