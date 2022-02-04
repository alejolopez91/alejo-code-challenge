class SessionsController < BaseController
  def show
    service = Slang::Sessions.new

    sorted_sessions = service.sort_sessions
    body = { "user_sessions": sorted_sessions }
    # post result
    api = Slang::Api.new
    response = api.post(body: body)

    render json: body, status: response.code
  end
end