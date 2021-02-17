require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "sign in" do
    it "signs user in and out" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get root_path
      expect(response).to render_template(:index)
    end
 end

  describe "post orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      service = FactoryBot.create(:service)
      category = FactoryBot.create(:category)
      expect { post orders_path, params: {order: {customer_id: customer.id, service_id: service.id, category_id: category.id, description: "text"} }
    }.to change(Order, :count)
      expect(response).to redirect_to order_path(id: Order.last.id)
    end
  end

  describe "get orders_path" do
    it "renders the index view" do
      category = FactoryBot.create_list(:category, 10)
      service = FactoryBot.create_list(:service, 10)
      customer = FactoryBot.create_list(:customer, 10)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get orders_path
       expect(response.status).to render_template(:index1)
    end
  end

end
