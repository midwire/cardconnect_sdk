require_relative 'request'
require_relative 'response'

module CardconnectSdk
  module SettlementStatus
    ENDPOINT = 'settlestat'

    def settlement_status_endpoint
      "#{url}#{ENDPOINT}"
    end

    def settlement_status_transaction(request)
      response = RestClient.get "#{settlement_status_endpoint}?merchid=#{request.merchid}&date=#{request.date}", default_headers      
      Response.from_json(response.body)
    end
  end
end
