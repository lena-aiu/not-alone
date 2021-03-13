require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "get show_order_path" do
    it "doesn't render the :show template if a user is not logged in" do
      order = FactoryBot.create(:order)
      get order_path(id: order.id)
      expect(response).to redirect_to(new_user_session_path)
    end
    it "renders the :show template for an administrator role" do
      order = FactoryBot.create(:order)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", 
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get order_path(id: order.id)
      expect(response).to render_template(:show)
    end
    it "renders the :show template for a volunteer role" do
      order = FactoryBot.create(:order)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", 
        password_confirmation: "Pa$$word20", role: "volunteer")
      sign_in user
      get order_path(id: order.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the customer index path if the order id is invalid" do
      order = FactoryBot.create(:order)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get order_path(id: 5000)
      expect(response).to redirect_to customers_path
    end
  end

  describe "get new_customer_order_path" do
    it "renders the :new template for an administrator role" do
      service = FactoryBot.create(:service)
      customer = FactoryBot.create(:customer)
      category = FactoryBot.create(:category)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get new_customer_order_path(customer_id: customer.id),
        params: {order: {service_id: service.id, category_id: category.id, description: "new"}}
      expect(response).to render_template(:new)
    end
    it "redirects to the new_user_session_path if a user is not logged in" do
      service = FactoryBot.create(:service)
      customer = FactoryBot.create(:customer)
      category = FactoryBot.create(:category)
      get new_customer_order_path(customer_id: customer.id),
        params: {order: {service_id: service.id, category_id: category.id, description: "new"}}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "get edit_order_path" do
    it "renders the :edit template for an administrator role" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", 
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      order = FactoryBot.create(:order)
      get edit_order_path(id: order.id)
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end
    it "redirects to the new_user_session_path if a user is not logged in" do
      order = FactoryBot.create(:order)
      get edit_order_path(id: order.id)
      expect(response).to redirect_to(new_user_session_path)
    end
    it "redirects to the new_user_session_path if the order id is invalid" do
      order = FactoryBot.create(:order)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", 
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get order_path(id: 1000)
      expect(response).to redirect_to customers_path
    end
  end

  describe "post orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the order" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", 
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      service = FactoryBot.create(:service)
      customer = FactoryBot.create(:customer)
      category = FactoryBot.create(:category)
      expect { post customer_orders_path(customer_id: customer.id),
        params: {order: {service_id: service.id, category_id: category.id,
        description: "new"}}
      }.to change(Order, :count)
      expect(response).to redirect_to Order.last
    end
  end

  describe "post orders_path with invalid data" do
    it "doesn't save a new entry and render an edit template for the order" do
      user = User.create(email: 'test@icloud.com', password: "Password20", 
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      service = FactoryBot.create(:service)
      customer = FactoryBot.create(:customer)
      expect { post customer_orders_path(customer_id: customer.id), 
        params: {order: { service_id: 1000, category_id: 5000,  
        description: nil}}
    }.not_to change(Order, :count)
      expect(response).to render_template(:edit)
    end
  end

  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the order" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      order = FactoryBot.create(:order)
      service = FactoryBot.create(:service)
      category = FactoryBot.create(:category)
      put order_path(id: order.id), params: {order: {
        service_id: service.id, category_id: category.id,  description: "new"}}
      order.reload
      expect(order.category_id).to eq(category.id)
      expect(order.service_id).to eq(service.id)
      expect(order.description).to eq("new")
      expect(response).to redirect_to order_path(id: order.id)
    end
  end

  describe "put order_path with invalid data" do
    it "doesn't update an entry and render an edit template for the order" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      order = FactoryBot.create(:order)
      put order_path(id: order.id), params: {order: {category_id: nil, description: ""}}
      order.reload
      expect(order.category_id).not_to eq(nil)
      expect(order.description).not_to eq("")
      expect(response.status).to render_template(:edit)
    end
  end

  describe "delete an order record" do
    it "deletes an order record and redirects to the customer index path" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order)
      customer = order.customer
      delete order_path(id: order.id)
      expect(response).to redirect_to customer
     end
  end
end
