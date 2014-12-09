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

end
