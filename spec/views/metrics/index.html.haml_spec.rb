require 'rails_helper'

RSpec.describe "metrics/index.html.haml", type: :view do
  before do
    assign(:grouping, 'day')
  end

  it "renders the modal component" do
    render
    # Check for the presence of the modal using data-controller since .modal is not present
    expect(rendered).to have_css('[data-controller="modal"]')
    # Check that the texts passed to the Modal component are displayed
    expect(rendered).to include(I18n.t('metrics.data_modal.title'))
    expect(rendered).to include(I18n.t('metrics.data_modal.description'))
    expect(rendered).to include(I18n.t('metrics.data_modal.add_data_button'))
  end

  it "renders the add data form" do
    render
    # Check for the presence of the form and fields
    expect(rendered).to have_css('form#new_metric_form')
    expect(rendered).to have_css('input[type="text"][name="name"]')
    expect(rendered).to have_css('input[type="number"][name="value"]')
    # Check the submit button by value since 'submit' is the type, not the text or value
    expect(rendered).to have_css("input[type='submit'][value=#{I18n.t('labels.add')}]")
  end

  it "renders the grouping selection form" do
    render
    # Check for the presence of the form and grouping selection
    expect(rendered).to have_css('form[method="get"]')
    Metric::GROUPING_TYPES.each do |grouping|
      expect(rendered).to include(grouping.capitalize)  # Assuming that the options are displayed capitalized
    end
  end

  it "displays the metrics chart" do
    render
    # Check for the presence of the turbo-frame and chart container
    expect(rendered).to have_css('turbo-frame#metrics_chart')
    expect(rendered).to have_css('div[id^="chart-"]')
    # Check that the Chartkick script is present (the content of include might need adjustments based on how the JS is rendered)
    expect(rendered).to include('new Chartkick["LineChart"]')
  end
end
