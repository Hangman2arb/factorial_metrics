class ApplicationController < ActionController::Base
  before_action :generate_api_service

  private

  def generate_api_service
    @api_service = ApiService.instance.configure(ApiKey.first.access_token)
  end
end
