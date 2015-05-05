require_relative 'request'
require_relative 'response'
require_relative 'batch'
require_relative 'transaction'

module CardconnectSdk
  module SettlementStatus
    ENDPOINT = 'settlestat'

    def settlement_status_endpoint
      "#{url}#{ENDPOINT}"
    end

    def settlement_status_for_batch(request)
      response = RestClient.get "#{settlement_status_endpoint}?merchid=#{request.merchid}&batchid=#{request.batchid}", default_headers
      Response.from_json(response.body)
    end

    def settlement_status_for_date(request)
      response = RestClient.get "#{settlement_status_endpoint}?merchid=#{request.merchid}&date=#{request.date}", default_headers
      Response.from_json(response.body)
    end

    def settlement_status_for_merchant(request)
      response = RestClient.get "#{settlement_status_endpoint}?merchid=#{request.merchid}", default_headers
      Response.from_json(response.body)
    end
  end
end
