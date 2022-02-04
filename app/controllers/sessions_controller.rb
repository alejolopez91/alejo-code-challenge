class SessionsController < BaseController
  def show
    service = Slang::Sessions.new

    service.sort_sessions

    render json: service.response, status: service.status
  end
end