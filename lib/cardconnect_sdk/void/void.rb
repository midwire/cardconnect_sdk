require_relative 'request'
require_relative 'response'

module CardconnectSdk
  module Void
    ENDPOINT = 'void'

    def void_endpoint
      "#{url}#{ENDPOINT}"
    end

    def void_transaction(request)
      response = RestClient.put void_endpoint, request.to_json, default_headers      
      Response.from_json(response.body)
    end
  end
end
