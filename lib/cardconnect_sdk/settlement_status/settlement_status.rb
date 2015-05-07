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

    def settlement_status(request)
      get_path = "#{settlement_status_endpoint}?merchid=#{request.merchid}"
      if !request.date.empty?
        get_path << "&date=#{request.date}"
      end
      if !request.batchid.empty?
        get_path << "&batchid=#{request.batchid}"
      end
      response = RestClient.get get_path, default_headers
      Response.from_json(response.body)
    end
  end
end
