require 'rails_helper'

RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
end

RSpec.describe "Sessions", type: :request do
  describe "sign in" do
    it "signs user in" do
      user = User.create(email: 'admin@example.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get customers_path
      expect(response).to render_template('customers/index')
    end
  end

  describe "sign out" do
    it "signs user out" do
      user = User.create(email: 'admin@example.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      sign_out user
      get customers_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "sign in" do
    it "signs in as an intern" do
      user = User.create(email: 'admin@example.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "intern")
      sign_in user
      get customers_path
      expect(response).to render_template('customers/index')
    end
  end

#need to continue working on it after making changes in orders_controller.rb
    describe "sign in" do
      it "signs in as a stranger" do
        user = User.create(email: 'admin@example.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "stranger")
        sign_in user
        get customers_path
        expect(response).to redirect_to home_index_path
      end
    end
end
