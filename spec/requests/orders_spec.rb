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
    it "saves a new entry and redirects to the show path for the order" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      expect { post customer_orders_path(service_id: service.id), params: {order: {category_id: category.id, status: "new"}}
    }.to change(Order, :count)
      expect(response).to redirect_to order_path(id: Order.last.id)
    end
  end

  describe "get orders_index_path" do
    it "renders the index view" do
      customer = FactoryBot.create(:customer)
      orders = FactoryBot.create_list(:order, 5)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get customer_order_path(service_id: service.id)
      expect(response.status).to render_template(:index)
    end
  end

  describe "get order_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get order_path(id: order.id)
      expect(response.status).to render_template(:show)
    end

    it "renders the :show template - redirects to the index path if the order id is invalid" do
      order = FactoryBot.create(:order)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get order_path(id: 1000)
      expect(response).to redirect_to customers_path
    end
  end

  describe "get edit_order_path" do
    it "renders the :edit template" do
      order = FactoryBot.create(:order)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get edit_order_path(id: order.id)
      expect(response.status).to eq(200)
    end
    it "renders the :edit template - redirects to the index path if the order id is invalid" do
      order = FactoryBot.create(:order)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get order_path(id: 1000)
      expect(response).to redirect_to customers_path
    end
  end

  describe "post orders_path with invalid data" do
    it "does not save a new entry and redirects to the new path for the order" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      expect { post customer_orders_path(service_id: service.id), params: {order: {status: "new"}}
      }.to change(Order, :count)
      expect(response.status).to render_template(:edit)
    end
  end

  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the order" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order)
      put order_path(id: service.id), params: {order: {service_id: service.id, category_id: category.id, status: "new"}}

      
      order.reload
      expect(order.customer_id).to eq(customer.id)
      expect(order.user_id).to eq(user.id)
      expect(order.status).to eq("new")
      expect(response).to redirect_to order_path(id: order.id)
    end
  end

  describe "put order_path with invalid data" do
    it "updates an entry and redirects to the edit path for the order" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order)
      put order_path(id: order.id), params: {order: {category_id: nil, status: ""}}
      order.reload
      expect(order.customer_id).not_to eq(nil)
      expect(order.user_id).not_to eq(nil)
      expect(order.status).not_to eq("")
      expect(response.status).to render_template(:edit)
    end
  end

  describe "delete an order record" do
    it "deletes an order record and redirects to the index path" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order)
      customer = order.customer
      delete order_path(id: order.id)
      expect(response).to redirect_to customer
     end
  end
end
