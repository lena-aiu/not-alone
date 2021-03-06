require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "sign in" do
    it "signs user in and out" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get root_path
      expect(response).to render_template(:index)
    end
  end

  describe "get customers_path" do
    it "renders the index view" do
      customer = FactoryBot.create_list(:customer, 10)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get customers_path
      expect(response.status).to render_template(:index)
    end
  end

  describe "get customer_path" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get customer_path(id: customer.id)
      expect(response.status).to render_template(:show)
    end
    it "renders the :show template - redirects to the index path if the customer id is invalid" do
      customer = FactoryBot.create(:customer)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get customer_path(id: 5000)
      expect(response).to redirect_to customers_path
    end
  end

  describe "get new_customer_path" do
    it "renders the :new template" do
      customer = FactoryBot.create(:customer)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get new_customer_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "get new_customer_path" do
    #bug in cards
    it "renders the :new template - redirects to the index path if the the user role is invalid" do
      customer = FactoryBot.create(:customer)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "stranger")
      sign_in user
      get new_customer_path
      # expect(response.status).to eq(404)
      expect(response).to redirect_to home_index_path
    end
  end

  describe "get edit_service_path" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get edit_customer_path(id: customer.id)
      expect(response.status).to render_template(:edit)
    end
    it "renders the :edit template - redirects to the index path if the customer id is invalid" do
      customer = FactoryBot.create(:customer)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get customer_path(id: 5000)
      expect(response).to redirect_to customers_path
    end
  end

  describe "post customers_path with valid data" do
    it "saves a new entry and redirects to the show path for the customer" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer_attributes = FactoryBot.attributes_for(:customer)
      expect { post customers_path, params: {customer: customer_attributes}
    }.to change(Customer, :count)
      expect(response).to redirect_to customer_path(id: Customer.last.id)
    end
  end

  describe "post customers_path with invalid data" do
    it "does not save a new entry and redirects to the new path for the customer" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator", role: "administrator")
      sign_in user
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { post customers_path, params: {customer: customer_attributes}
    }.to_not change(Customer, :count)
      expect(response.status).to render_template(:new)
    end
  end

  describe "put customer_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      put customer_path(id: customer.id), params: {customer:{first_name: "new", last_name: "new", phone: "1234567890", email: "new@new.com", street: "1 New St 1 Apt", city: "New", state: "NY", zip: "10000"}}
      customer.reload
      expect(customer.first_name).to eq("new")
      expect(response).to redirect_to customer_path(id: customer.id)
    end
  end

  describe "put customer_path with invalid data" do
    it "updates an entry and redirects to the edit path for the customer" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      put customer_path(id: customer.id), params: {customer: {first_name: "", last_name: "", phone: "", email: "", street: "", city: "", state: "", zip: ""}}
      customer.reload
      expect(customer.first_name).to_not eq("nil")
      expect(response.status).to render_template(:edit)
    end
  end

  describe "delete a customer record and redirects to the index path" do
    it "deletes a customer record" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      expect {delete customer_path(id: customer.id)}.to change(Customer, :count)
      expect(response).to redirect_to customers_path
     end
  end
end
