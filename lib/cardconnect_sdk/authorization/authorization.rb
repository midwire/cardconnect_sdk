require_relative 'request'
require_relative 'response'

module CardconnectSdk
  module Authorization
    ENDPOINT = 'auth'

    def auth_endpoint
      "#{url}#{ENDPOINT}"
    end

    def authorize_transaction(request)
      response = RestClient.put auth_endpoint, request.to_json, default_headers      
      Response.from_json(response.body)
    end
  end
end
