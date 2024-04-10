# Factorial Metrics

This is a technical test submission for Factorial. The application is a Frontend + Backend system designed to post and visualize metrics. Each metric includes a timestamp, name, and value, displayed on a timeline with averages calculated per minute, hour, and day. All metrics are persisted in the database, showcasing a clear separation between the API and the Frontend.

## Requirements

- Ruby 3.3.0
- Rails 7.1.3.2
- PostgreSQL
- Node.js and Yarn

## Initial Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/Hangman2arb/factorial_metrics.git
   cd factorial_metrics
   ```

2. Install Ruby and Yarn dependencies:

   ```bash
   bundle install
   yarn install
   ```

3. Create and migrate the database:

   ```bash
   rails db:create db:migrate
   ```

4. Seed the database (optional):

   To have sample data to work with, run:

   ```bash
   rails db:seed
   ```

## API Key Generation

Authentication with the API requires an API key. Generate one using the command:

```bash
rake api_key:generate
```

This command will provide you with an API key to use in your requests.

## Running the Application

Start the application using:

```bash
bin/dev
```

This command will boot up the Rails server along with processes for compiling JavaScript and CSS.

## Running Tests

Execute the test suite with:

```bash
rspec
```

## Test Suite Overview

The test suite comprehensively covers various aspects of the application, ensuring its reliability and correctness. Here's a breakdown of what each test file covers:

### Factories

- `spec/factories/api_keys.rb`:
    - Tests the validity of the API key factory.

- `spec/factories/metrics.rb`:
    - Tests the validity of the Metric factory.

### Model Specifications

- `spec/models/api_key_spec.rb`:
    - Ensures API keys are valid with the correct attributes.
    - Checks that an access token is generated before creation.
    - Verifies that API keys are active by default.

- `spec/models/metric_spec.rb`:
    - Validates metrics with the correct attributes.
    - Checks for the presence of a name and value.
    - Ensures values are numeric.

### Request Specifications

- `spec/requests/api/v1/metrics_spec.rb`:
    - `GET /index`: Tests metric retrieval grouped by minute, hour, or day and checks for correct averages.
    - `POST /create`: Tests metric creation with valid and invalid parameters.

- `spec/requests/metrics_spec.rb`:
    - `GET #index`: Verifies that the index page renders correctly.
    - `GET #data`: Tests data retrieval and rendering from the API.
    - `POST #create`: Checks the metric creation process and its response handling.

### View Specifications

- `spec/views/metrics/index.html.haml_spec.rb`:
    - Ensures the modal component and its texts are rendered.
    - Validates the presence of the add data form and its fields.
    - Checks the rendering of the grouping selection form.
    - Verifies that the metrics chart is displayed correctly.

This structure provides a clear and concise overview of the tests, making it easier to understand the coverage and purpose of each test file in the suite.

