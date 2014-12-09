FactoryGirl.define do
  factory :inquire_request, class: CardconnectSdk::Inquire::Request do
    merchid ENV['CARDCONNECT_MERCHANT_ID']
    retref nil
  end
end
