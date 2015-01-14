require_relative 'request'
require_relative 'response'

module CardconnectSdk
  module Inquire
    ENDPOINT = 'inquire'

    def inquire_endpoint
      "#{url}#{ENDPOINT}"
    end

    def inquire_transaction(request)
      response = RestClient.get "#{inquire_endpoint}/#{request.retref}/#{request.merchid}", default_headers      
      Response.from_json(response.body)
    end
  end
end
