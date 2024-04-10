require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  it "has a valid factory" do
    api_key = create(:api_key)
    expect(api_key).to be_valid
  end

  it "generates access token before creation" do
    api_key = build(:api_key)
    expect(api_key.access_token).not_to be_nil
  end

  it "is active by default" do
    api_key = build(:api_key)
    expect(api_key.active).to be_truthy
  end
end
