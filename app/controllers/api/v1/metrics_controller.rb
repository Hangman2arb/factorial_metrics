module Api
  module V1
    class MetricsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authenticate

      def index
        grouping = params[:grouping].presence_in(Metric::GROUPING_TYPES)

        if grouping.nil?
          render json: { error: "Invalid grouping parameter" }, status: :bad_request
          return
        end

        metrics = Metric.all
        render json: metrics.send("group_by_#{grouping}", :created_at).average(:value)
      end

      def create
        metric = Metric.new(metric_params)
        if metric.save
          render json: metric, status: :created
        else
          render json: { error: metric.errors.full_messages.first }, status: :unprocessable_entity
        end
      end

      private

      def metric_params
        params.require(:metric).permit(:name, :value)
      end

      def authenticate
        authenticate_or_request_with_http_token do |token, _|
          ApiKey.exists?(access_token: token, active: true)
        end
      end
    end
  end
end
