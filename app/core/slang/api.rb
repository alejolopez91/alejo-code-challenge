require "httparty"

module Slang
  class Api
    attr_reader :base_url, :headers

    def initialize(base_url: "https://api.slangapp.com")
      @base_url = base_url
      auth_key = ENV["AUTH_KEY"] || "Basic MTU6RmpwbVVTaW9jRmhMMWZYaEQ0TnJWNWtGL2UrUFBOTTlVVm9YY1pOME9laz0="
      @headers = { 
        "Content-Type": "application/json",
        "Authorization": auth_key
       }
    end

    def get(path: "challenges/v1/activities", params: {})
      url = "#{base_url}/#{path}"
      # log params of request with company logger

      HTTParty.get(url, headers: headers, query: params)
    end

    def post(path: "challenges/v1/activities/sessions", body: {})
      url = "#{base_url}/#{path}"
      # log params of request with company logger

      HTTParty.post(url, body: body, headers: headers)
    end
  end
end
