require 'rails_helper'

RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
end

RSpec.describe "Services", type: :request do
  describe "sign in" do
    it "signs user in and out" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20",
        role: "administrator")
      sign_in user
      get root_path
      expect(response).to render_template(:index)
    end
  end

  describe "get services_path" do
    it "renders the index view" do
      service = FactoryBot.create_list(:service, 10)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20",
        role: "administrator")
      get services_path
      expect(response).to render_template(:index)
    end
  end

  describe "get service_path" do
    it "renders the :show template for an administrator role" do
      service = FactoryBot.create(:service)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      get service_path(id: service.id)
      expect(response).to render_template(:show)
    end
    it "renders the :show template - redirects to the index path if the service id is invalid" do
      service = FactoryBot.create(:service)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      get service_path(id: 5000)
      expect(response).to redirect_to services_path
    end
  end

  describe "get new_service_path" do
    it "renders the :new template for an administrator role" do
      service = FactoryBot.create(:service)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get new_service_path(id: service.id)
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
    it "redirects to the new_user_session_path if a user is not logged in" do
      service = FactoryBot.create(:service)
      get new_service_path(id: service.id)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "get edit_service_path" do
    it "renders the :edit template for an administrator role" do
      service = FactoryBot.create(:service)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get edit_service_path(id: service.id)
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end
    it "redirects to the new_user_session_path if a user is not logged in" do
      service = FactoryBot.create(:service)
      get edit_service_path(id: service.id)
      expect(response).to redirect_to(new_user_session_path)
    end
    it "redirects to the index path if the service id is invalid" do
      service = FactoryBot.create(:service)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get service_path(id: 5000)
      expect(response).to redirect_to services_path
    end
  end

  describe "post services_path with valid data" do
    it "saves a new entry and redirects to the show path for the service" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      service_attributes = FactoryBot.attributes_for(:service)
      expect { post services_path, params: {service: service_attributes}
    }.to change(Service, :count)
      expect(response).to redirect_to service_path(id: Service.last.id)
    end
  end

  describe "post services_path with invalid data" do
    it "doesn't save a new entry and redirects to the new path for the service" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      service_attributes = FactoryBot.attributes_for(:service)
      service_attributes.delete(:name)
      expect { post services_path, params: {service: service_attributes}
    }.to_not change(Service, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "put service_path with valid data" do
    it "updates an entry and redirects to the show path for the service" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      service = FactoryBot.create(:service)
      put service_path(id: service.id), params: {service:{name: "new", description: "new", kind: "new",
        phone_number: "1234567890", street: "1 New St 1 Apt", city: "New", state: "NY", zip: "10000"}}
      service.reload
      expect(service.name).to eq("new")
      expect(service.description).to eq("new")
      expect(service.kind).to eq("new")
      expect(service.phone_number).to eq("1234567890")
      expect(service.street).to eq("1 New St 1 Apt")
      expect(service.city).to eq("New")
      expect(service.state).to eq("NY")
      expect(service.zip).to eq("10000")
      expect(response).to redirect_to service_path(id: service.id)
    end
  end

  describe "put service_path with invalid data" do
    it "doesn't updates an entry and redirects to the edit path for the service" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      service = FactoryBot.create(:service)
      put service_path(id: service.id), params: {service: {name: "", description: "", kind: "", phone_number: "",
        street: "", city: "", state: "", zip: ""}}
      service.reload
      expect(service.name).to_not eq("")
      expect(service.description).to_not eq("")
      expect(service.kind).to_not eq("")
      expect(service.phone_number).to_not eq("")
      expect(response).to render_template(:edit)
    end
  end

  describe "delete a service record and redirects to the index path" do
    it "deletes a service record" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      service = FactoryBot.create(:service)
      expect {delete service_path(id: service.id)}.to change(Service, :count)
      expect(response).to redirect_to services_path
     end
  end
end
