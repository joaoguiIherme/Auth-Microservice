require 'rails_helper'

RSpec.describe "Auth", type: :request do
  let(:user) { User.create(name: "Test User", email: "test@example.com", password: "password123") }

  describe "POST /auth/register" do
    it "registers a new user" do
      post '/auth/register', params: { user: { name: "Test User", email: "test2@example.com", password: "password123", password_confirmation: "password123" } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "POST /auth/login" do
    it "logs in a user" do
      post '/auth/login', params: { email: user.email, password: "password123" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key("token")
    end
  end

  describe "GET /auth/validate" do
    it "validates a token" do
      token = JsonWebToken.encode(user_id: user.id)
      get '/auth/validate', headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
  end
end
