require_relative 'request'
require_relative 'response'

module CardconnectSdk
  module Refund
    ENDPOINT = 'refund'

    def refund_endpoint
      "#{url}#{ENDPOINT}"
    end

    def refund_transaction(request)
      response = RestClient.put refund_endpoint, request.to_json, default_headers      
      Response.from_json(response.body)
    end
  end
end
