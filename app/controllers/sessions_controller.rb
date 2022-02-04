class SessionsController < BaseController
  def show
    service = Slang::Sessions.new

    sorted_sessions = service.sort_sessions
    # post result
    response = service.post_results

    render json: { "user_sessions": sorted_sessions }, status: response.code
  end
end