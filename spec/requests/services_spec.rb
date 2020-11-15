require 'rails_helper'

RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
end #lo cambie a spec_helper.rb

RSpec.describe "Services", type: :request do
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

  describe "get services_path" do  
    it "renders the index view" do
      service = FactoryBot.create_list(:service, 10)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password") 
      sign_in user 
      get services_path
      expect(response.status).to eq(200)
    end
  end 

  describe "get service_path" do
    it "renders the :show template" do
      service = FactoryBot.create(:service)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      #service GET    /services/:id(.:format)  
      get service_path(id: service.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the service id is invalid" do
      get service_path(id: 5000) #an ID that doesn't exist
      expect(response).to be_redirect
    end
  end

  describe "get new_service_path" do
    it "renders the :new template" do
      service = FactoryBot.create(:service)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      get new_service_path 
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "get edit_service_path" do
    it "renders the :edit template" do
      service = FactoryBot.create(:service)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      get edit_service_path(id: service.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the customer id is invalid" do
      get service_path(id: 5000) #an ID that doesn't exist
      expect(response).to be_redirect
    end  
  end
#POST       /services(.:format)                                                               
  describe "post services_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do   
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      service_attributes = FactoryBot.attributes_for(:service)
      expect { post services_path, params: {service: service_attributes}
    }.to change(Service, :count)
      expect(response).to redirect_to service_path(id: Service.last.id)
    end
  end

  describe "post services_path with invalid data" do
    it "does not save a new entry or redirect" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      service_attributes = FactoryBot.attributes_for(:service)
      service_attributes.delete(:name)
      expect { post services_path, params: {service: service_attributes}
    }.to_not change(Service, :count)
      expect(response.status).to eq(200)
    end
  end  

  describe "put service_path with valid data" do
    it "updates an entry and redirects to the show path for the service" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user     
      service = FactoryBot.create(:service) #create or build
      put service_path(id: service.id), params: {service:{name: "new"}}
      service.reload
      expect(service.name).to eq("new")
      expect(response).to redirect_to service_path(id: service.id)
    end
  end

  describe "put service_path with invalid data" do    
    it "updates an entry and redirects to the show path for the service" do     
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user 
      service = FactoryBot.create(:service) #create or build
      put service_path(id: service.id), params: {service: {name: ""}}
      service.reload
      expect(service.name).to_not eq("nil")
      expect(response.status).to eq(200)
    end
  end

  describe "delete a service record" do
    it "deletes a service record" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user 
      service = FactoryBot.create(:service)
      delete service_path(id: service.id), params: {service:{name: "new"}}
#     #expect(response).to have_http_status(:success)
      expect { delete services_path(id: service.id).to eq("new")}
     end
  end
end #FINAL END 



