FactoryGirl.define do
  factory :void_request, class: CardconnectSdk::Void::Request do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    retref nil
    amount '0.99'
  end
end
