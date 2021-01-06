require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "sign in" do
    it "signs user in and out" do 
      #user = User.create(email: 'admin@example.com', password: "password", password_confirmation: "password") ## uncomment if not using FactoryBot
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password") 
      sign_in user
      get root_path
      #expect(page).to include('test@icloud.com')
      expect(response).to render_template(:index)    
    # sign_out (:user, email: 'test@icloud.com') #user
    # get root_path
    # expect(page).not_to include('test@icloud.com')
    #expect(response).not_to render_template(:index)
    end
  end
    # describe "GET /customers" do
    #   it "works! (now write some real specs)" do
    #     get customers_path
    #     expect(response).to have_http_status(302)
    #   end
  describe "get customers_path" do  
    it "renders the index view" do
      service = FactoryBot.create_list(:customer, 10)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password") 
      sign_in user 
      get customers_path
      expect(response.status).to eq(200)
    end
  end
end
