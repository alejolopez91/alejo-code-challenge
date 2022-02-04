module Slang
  class Activities
    attr_reader :api_client

    ACTIVITIES_PATH = "challenges/v1/activities".freeze

    def initialize(api_client: Slang::Api.new)
      @api_client = api_client
    end

    def get_activities
      path = ACTIVITIES_PATH
      params = {}
      
      get_request(path: path, params: params)
    end

    private

    def get_request(path:, params:)
      # Log request info
      party_response = api_client.get(path: path, params: params)

      if party_response.success?
        @status = :ok
        @response = party_response.parsed_response
      else
        @status = party_response.code
        @response = party_response.parsed_response
      end
    end
  end
end
