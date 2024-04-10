namespace :api_key do
  desc "Generate a standalone API key"
  task generate: :environment do
    api_key = ApiKey.create
    if api_key.persisted?
      puts "Generated API key: #{api_key.access_token}"
    else
      puts "Failed to generate API key"
    end
  end
end