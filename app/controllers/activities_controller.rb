class ActivitiesController < BaseController
  def show
    service = Slang::Activities.new

    service.get_activities

    render json: service.response, status: service.status
  end
end