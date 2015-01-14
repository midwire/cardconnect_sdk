require_relative 'request'
require_relative 'response'
require_relative 'adjustment'
require_relative 'funding_node'
require_relative 'transaction'

module CardconnectSdk
  module Funding
    ENDPOINT = 'funding'

    def funding_endpoint
      "#{url}#{ENDPOINT}"
    end

    def funding_transaction(request)
      response = RestClient.get "#{funding_endpoint}?merchid=#{request.merchid}&date=#{request.date}", default_headers      
      Response.from_json(response.body)
    end
  end
end
