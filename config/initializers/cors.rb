Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(
      "http://localhost:8080",
      "http://localhost:5173",
      "http://localhost:3000",
      "https://kit.ac.zw",
      "https://www.kit.ac.zw",
      "https://dulcet-travesseiro-ee79ad.netlify.app"
    )

    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: ["Authorization"],
      credentials: false
  end
end