require "bundler/setup"
require "simple_request"

def headers
  token = SimpleRequest.post(
    url: 'http://localhost:3000/v1/admin/auth/login',
    body: { admin: { email: 'simple@request.co', password: 'password' } },
    headers: {}
  ).json['data']['token']

  {
    'Authorization' => "Bearer #{token}"
  }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
