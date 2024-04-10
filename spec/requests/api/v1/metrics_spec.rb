require 'rails_helper'

RSpec.describe "Api::V1::Metrics", type: :request do
  describe "GET /index" do
    let(:api_key) { create(:api_key) }
    let(:headers) { { 'Authorization' => "Bearer #{api_key.access_token}" } }

    before do
      create_list(:metric, 10, created_at: 1.day.ago)
    end

    Metric::GROUPING_TYPES.each do |grouping|
      context "with '#{grouping}' parameter" do
        it "returns metrics grouped by #{grouping} with correct averages" do
          get api_v1_metrics_path, params: { grouping: grouping }, headers: headers

          expect(response).to have_http_status(:success)
          json_response = JSON.parse(response.body)

          expect(json_response.keys).to match_array(expected_grouping_keys(grouping))

          json_response.each do |key, average_value|
            expected_metrics = Metric.where("DATE_TRUNC('#{grouping}', created_at) = ?", key)
            expected_average = expected_metrics.average(:value)

            expect(average_value.to_f).to be_within(0.01).of(expected_average)
          end
        end
      end
    end

    it 'returns a 400 status code when invalid grouping parameter is provided' do
      get api_v1_metrics_path, params: { grouping: 'invalid_parameter' }, headers: headers

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "POST /create" do
    let(:api_key) { create(:api_key) }
    let(:headers) { { 'Authorization' => "Bearer #{api_key.access_token}", 'Content-Type' => 'application/json' } }

    context 'with valid parameters' do
      it 'creates a new Metric and returns a 201 status code' do
        expect {
          post api_v1_metrics_path, params: { metric: { name: 'Test', value: 10 } }.to_json, headers: headers
        }.to change(Metric, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Metric and returns a 422 status code' do
        expect {
          post api_v1_metrics_path, params: { metric: { name: '', value: 10 } }.to_json, headers: headers
        }.not_to change(Metric, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  def expected_grouping_keys(grouping)
    case grouping
    when 'day'
      Metric.all.map { |metric| metric.created_at.to_date.to_s }.uniq
    when 'hour'
      Metric.all.map { |metric| metric.created_at.beginning_of_hour.utc.to_s }.uniq
    when 'minute'
      Metric.all.map { |metric| metric.created_at.beginning_of_minute.utc.to_s }.uniq
    else
      []
    end
  end

end
