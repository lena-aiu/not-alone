require 'rails_helper'

RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
end #lo cambie a spec_helper.rb

RSpec.describe "Assignments", type: :request do
  describe "sign in" do
    it "signs user in and out" do
      #user = User.create(email: 'admin@example.com', password: "password", password_confirmation: "password") ## uncomment if not using FactoryBot
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
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

  describe "get assignments_index_path" do
    it "renders the index view" do
      #assignment = FactoryBot.create_list(:assignment, 10)
      # #user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      customer = FactoryBot.create_list(:customer, 10)
      user = FactoryBot.create_list(:user, 10)
      assignments = FactoryBot.create_list(:assignment, 10)
      get assignments_index_path
      expect(response.status).to eq(200)
    end
  end

  describe "get assignment_path" do
    it "renders the :show template" do
      assignment = FactoryBot.create(:assignment)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      #service GET    /services/:id(.:format)
      get assignment_path(id: assignment.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the assignment id is invalid" do
      get assignment_path(id: 5000) #an ID that doesn't exist
      expect(response.status).to be_redirect
    end
  end

  # describe "get new_assignment_path" do
  #   it "renders the :new template" do
  #     customer = FactoryBot.create(:customer)
  #     user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
  #     sign_in user
  #     get new_customer_path
  #     expect(response).to be_successful
  #     expect(response).to render_template(:new)
  #   end
  # end

  describe "get edit_assignment_path" do
    it "renders the :edit template" do
      assignment = FactoryBot.create(:assignment)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      get edit_assignment_path(id: assignment.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the assignment id is invalid" do
      get assignment_path(id: 5000) #an ID that doesn't exist
      expect(response.status).to be_redirect
    end
  end
#POST       /services(.:format)
  describe "post assignments_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      user = FactoryBot.create(:user)
      expect { post customer_assignments_path, params: {assignment: {user_id: user.id, status: "new"}}
    }.to change(Assignment, :count)
      expect(response).to redirect_to assignment_path(id: Assignment.last.id)
    end
  end

  describe "post assignments_path with invalid data" do
    it "does not save a new entry or redirect" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      user = FactoryBot.create(:user)
      assignment = FactoryBot.create(:assignment)
      assignment.delete(:assignment)
      expect { post customer_assignments_path, params: {assignment: {user_id: user.id, status: "new"}}
    }.to_not change(Assignment, :count)
      expect(response.status).to eq(200)
    end
  end

  describe "put assignment_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      user = FactoryBot.create(:user)
      assignment = FactoryBot.create(:assignment)
      put assignment_path(id: assignment.id), params: {assignment: {customer_id: "1", user_id: "1", status: "new"}}
      assignment.reload
      expect(assignment.customer_id).to eq("1")
      expect(assignment.user_id).to eq("1")
      expect(assignment.status).to eq("new")
      expect(response).to redirect_to assignment_path(id: assignment.id)
    end
  end

  describe "put assignment_path with invalid data" do
    it "updates an entry and redirects to the show path for the assignment" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      user = FactoryBot.create(:user)
      assignment = FactoryBot.create(:status)
      put assignment_path(id: assignment.id), params: {assignment: {customer_id: "nil", user_id: "nil", status: ""}}
      assignment.reload
      expect(assignment.customer_id).to eq("nil")
      expect(assignment.user_id).to eq("nil")
      expect(assignment.status).to eq("")
      expect(response.status).to eq(200)
    end
  end

  describe "delete a assignment record" do
    it "deletes a assignment record" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      user = FactoryBot.create(:user)
      assignment = FactoryBot.create(:status)
      delete assignment_path(id: assignment.id), params: {assignment: {customer_id: "1", user_id: "1", status: "new"}}
      # expect { delete assignments_path(id: assignment.id).to eq("new")}
      expect(response).to render_template(:index)
     end
  end
end
