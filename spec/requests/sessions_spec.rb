require 'rails_helper'

RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
end #lo cambie a spec_helper.rb

RSpec.describe "Sessions", type: :request do
  describe "sign in" do
    it "signs user in and out" do
      #user = create(:user)    ## uncomment if using FactoryBot
      user = User.create(email: 'admin@example.com', password: "password", password_confirmation: "password", role: "administrator") ## uncomment if not using FactoryBot
      #user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password") ## uncomment if not using FactoryBot
      sign_in user
      get root_path
      expect(response).to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.
    end
  end

  describe "sign out" do
    it "signs user in and out" do
      #user = create(:user)    ## uncomment if using FactoryBot
      user = User.create(email: 'admin@example.com', password: "password", password_confirmation: "password", role: "administrator") ## uncomment if not using FactoryBot
      #user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password") ## uncomment if not using FactoryBot
      sign_out user
      get root_path
      expect(response).not_to render_template(:home) # add gem 'rails-controller-testing' to your Gemfile first.
    end
  end
end
