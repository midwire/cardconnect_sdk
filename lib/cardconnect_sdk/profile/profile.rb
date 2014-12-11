require_relative 'account'
require_relative 'request'
require_relative 'response'
require_relative 'create_update_request'
require_relative 'create_update_response'
require_relative 'delete_request'
require_relative 'delete_response'

module CardconnectSdk
  module Profile
    ENDPOINT = 'profile'

    def profile_endpoint
      "#{url}#{ENDPOINT}"
    end

    def get_profile(request)
      response = RestClient.get "#{profile_endpoint}/#{request.profileid}/#{request.acctid}/#{request.merchid}", default_headers      
      Response.from_json(response.body)
    end

    def create_profile(create_request)
      response = RestClient.put profile_endpoint, create_request.to_json, default_headers
      CreateUpdateResponse.from_json(response.body)
    end

    def update_profile(update_request)
      response = RestClient.put profile_endpoint, update_request.to_json, default_headers
      CreateUpdateResponse.from_json(response.body)
    end

    def delete_profile(delete_request)
      response = RestClient.delete "#{profile_endpoint}/#{delete_request.profileid}/#{delete_request.acctid}/#{delete_request.merchid}", default_headers      
      DeleteResponse.from_json(response.body)
    end

  end
end
