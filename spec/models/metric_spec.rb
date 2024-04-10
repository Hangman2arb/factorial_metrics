require 'rails_helper'

RSpec.describe Metric, type: :model do
  it "is valid with valid attributes" do
    metric = build(:metric, name: "Example Metric", value: 100.0)
    expect(metric).to be_valid
  end

  it "is not valid without a name" do
    metric = build(:metric, name: nil, value: 100.0)
    expect(metric).not_to be_valid
  end

  it "is not valid without a value" do
    metric = build(:metric, name: "Example Metric", value: nil)
    expect(metric).not_to be_valid
  end

  it "is not valid with a non-numeric value" do
    metric = build(:metric, name: "Example Metric", value: "non-numeric")
    expect(metric).not_to be_valid
  end
end
