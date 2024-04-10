class MetricsController < ApplicationController
  before_action :get_grouping, only: [:index, :data]

  def index
  end

  def data
    Rails.logger.debug "@api_service class: #{@api_service.class}"
    response = @api_service.get_metrics(@grouping)

    if response.success?
      render json: response
    else
      render json: { error: 'Error fetching data' }, status: :unprocessable_entity
    end
  end

  def create
    response = @api_service.create_metric(params[:name], params[:value], { 'Content-Type' => 'application/json' })

    if response.code == 201
      redirect_to root_path, notice: "Metric was successfully created."
    else
      render turbo_stream: turbo_stream.replace('error_message', partial: 'metrics/error', locals: { error: JSON.parse(response.body)['error'] })
    end
  end

  private

  def get_grouping
    @grouping = Metric::GROUPING_TYPES.include?(params[:grouping]) ? params[:grouping] : Metric::GROUPING_TYPES.first
  end
end
