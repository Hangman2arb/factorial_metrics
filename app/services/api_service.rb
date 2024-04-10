class ApiService
  include Singleton

  def configure(api_key)
    @api_key = api_key
    @base_url = "http://localhost:3000/api/v1"
    return self
  end

  def get_metrics(grouping, headers = {})
    headers = default_headers.merge(headers)
    HTTParty.get("#{@base_url}/metrics", query: { grouping: grouping }, headers: headers)
  end

  def create_metric(name, value, headers = {})
    headers = default_headers.merge(headers)
    HTTParty.post("#{@base_url}/metrics", body: { metric: { name: name, value: value } }.to_json, headers: headers)
  end

  private

  def default_headers
    { 'Authorization' => "Bearer #{@api_key}" }
  end
end
