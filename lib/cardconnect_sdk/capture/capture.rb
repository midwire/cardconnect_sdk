require_relative 'request'
require_relative 'response'

module CardconnectSdk
  module Capture
    ENDPOINT = 'capture'

    def capture_endpoint
      "#{url}#{ENDPOINT}"
    end

    def capture_transaction(request)
      response = RestClient.put capture_endpoint, request.to_json, default_headers      
      Response.from_json(response.body)
    end
  end
end
