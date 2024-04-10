require 'rails_helper'

RSpec.describe "Metrics", type: :request do
  before do
    create(:api_key, access_token: "testtoken", active: true)
  end

  describe "GET #index" do
    it "renders the index template" do
      get metrics_path
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #data" do
    let(:grouping) { Metric::GROUPING_TYPES.first }
    let(:api_response) { instance_double(HTTParty::Response, success?: true, body: {}.to_json) }

    before do
      allow_any_instance_of(ApiService).to receive(:get_metrics).and_return(api_response)
    end

    it "fetches data from the API and renders it" do
      get data_metrics_path, params: { grouping: grouping }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST #create" do
    let(:metric_params) { { name: 'Test Metric', value: 10 } }
    let(:api_response) { instance_double(HTTParty::Response, code: 201, body: {}.to_json) }

    before do
      allow_any_instance_of(ApiService).to receive(:create_metric).and_return(api_response)
    end

    it "calls ApiService to create a metric and redirects" do
      post metrics_path, params: { metric: metric_params }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Metric was successfully created.")
    end

    context "when the API call is unsuccessful" do
      let(:api_response) { instance_double(HTTParty::Response, code: 422, body: { error: ['Error message'] }.to_json) }

      it "does not create a metric and responds with Turbo Stream" do
        post metrics_path, params: { metric: metric_params }

        expect(response.content_type).to include("text/vnd.turbo-stream.html")

        expect(response.body).to include('Error message')
      end
    end
  end
end
