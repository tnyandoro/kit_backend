Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # IMPORTANT: Add 8080 because that is where your React app is running!
    origins 'http://localhost:8080', 'http://localhost:5173', 'http://localhost:3000'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization']
  end
end