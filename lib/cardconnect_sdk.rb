# Create a .env.test and a .development.env for your different local environments
require 'dotenv'
paths = %W(.env .env.#{ENV['APP_ENV']}).map { |name| Dir.pwd + '/' + name }
Dotenv.load(
  *paths
).each { |k, v| ENV[k] = v }

require 'cardconnect_sdk/version'

module CardconnectSdk
  def self.root
    Pathname.new(File.dirname(__FILE__)).parent
  end

  autoload :Client,            'cardconnect_sdk/client'
  autoload :Attributable,      'cardconnect_sdk/attributable'
  autoload :Authorization,     'cardconnect_sdk/authorization/authorization'
  autoload :Capture,           'cardconnect_sdk/capture/capture'
  autoload :Void,              'cardconnect_sdk/void/void'
  autoload :Refund,            'cardconnect_sdk/refund/refund'
  autoload :Inquire,           'cardconnect_sdk/inquire/inquire'
  autoload :SettlementStatus,  'cardconnect_sdk/settlement_status/settlement_status'
  autoload :Deposit,           'cardconnect_sdk/deposit/deposit'
  autoload :Funding,           'cardconnect_sdk/funding/funding'
  autoload :Profile,           'cardconnect_sdk/profile/profile'
  autoload :Helpers,           'cardconnect_sdk/helpers/helpers'

end
