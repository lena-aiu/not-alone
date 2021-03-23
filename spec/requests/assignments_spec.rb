require 'rails_helper'

RSpec.describe "Assignments", type: :request do
  describe "get show_assignment_path" do
    it "doesn't render the :show template if a user is not logged in" do
      assignment = FactoryBot.create(:assignment)
      get assignment_path(id: assignment.id)
      expect(response).to redirect_to(new_user_session_path)
    end
    it "renders the :show template for an administrator role" do
      assignment = FactoryBot.create(:assignment)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get assignment_path(id: assignment.id)
      expect(response).to render_template(:show)
    end
    it "renders the :show template for a volunteer" do
      assignment = FactoryBot.create(:assignment)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "volunteer")
      sign_in user
      get assignment_path(id: assignment.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the customer index path if the assignment id is invalid" do
      assignment = FactoryBot.create(:assignment)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get assignment_path(id: 5000)
      expect(response).to redirect_to customers_path
    end
  end

  describe "get new_customer_assignment_path" do
    it "renders the :new template for an administrator role" do
      customer = FactoryBot.create(:customer)
      assignment = FactoryBot.create(:assignment)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get new_customer_assignment_path(customer_id: customer.id),
        params: {assignment: {status: "new"}}
      expect(response).to render_template(:new)
    end
    it "redirects to the new_user_session_path if a user is not logged in" do
      customer = FactoryBot.create(:customer)
      assignment = FactoryBot.create(:assignment)
      get new_customer_assignment_path(customer_id: customer.id,
        assignment_id: assignment.id)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "get edit_assignment_path" do
    it "renders the :edit template for an administrator role" do
      assignment = FactoryBot.create(:assignment)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get edit_assignment_path(id: assignment.id)
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end
    it "redirects to the new_user_session_path if a user is not logged in" do
      assignment = FactoryBot.create(:assignment)
      get edit_assignment_path(id: assignment.id)
      expect(response).to redirect_to(new_user_session_path)
    end
    it "redirects to the index path if the assignment id is invalid" do
      assignment = FactoryBot.create(:assignment)
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      get assignment_path(id: 5000)
      expect(response).to redirect_to customers_path
    end
  end

  describe "post assignments_path with valid data" do
    it "saves a new entry and redirects to the show path for the assignment" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      expect { post customer_assignments_path(customer_id: customer.id),
        params: {assignment: {user_id: user.id, status: "new"}}
    }.to change(Assignment, :count)
      expect(response).to redirect_to assignment_path(id: Assignment.last.id)
    end
  end

  describe "post assignments_path with invalid data" do
    it "doesn't save a new entry and render an edit template for the assignment" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      expect { post customer_assignments_path(customer_id: customer.id), params: {assignment: {status: "new"}}
        }.to_not change(Assignment, :count)
      expect(response).to render_template(:edit)
    end
  end

  describe "put assignment_path with valid data" do
    it "updates an entry and redirects to the show path for the assignment" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      assignment = FactoryBot.create(:assignment)
      put assignment_path(id: assignment.id), params: {assignment: {customer_id: customer.id,
        user_id: user.id, status: "new"}}
      assignment.reload
      expect(assignment.customer_id).to eq(customer.id)
      expect(assignment.user_id).to eq(user.id)
      expect(assignment.status).to eq("new")
      expect(response).to redirect_to assignment_path(id: assignment.id)
    end
  end

  describe "put assignment_path with invalid data" do
    it "doesn't update an entry and render an edit template for the assignment" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      assignment = FactoryBot.create(:assignment)
      put assignment_path(id: assignment.id), params: {assignment: {user_id: nil, status: ""}}
      assignment.reload
      expect(assignment.customer_id).not_to eq(nil)
      expect(assignment.user_id).not_to eq(nil)
      expect(assignment.status).not_to eq("")
      expect(response).to render_template(:edit)
    end
  end

  describe "delete a assignment record" do
    it "deletes a assignment record and redirects to the customer index path" do
      user = User.create(email: 'test@icloud.com', password: "Pa$$word20",
        password_confirmation: "Pa$$word20", role: "administrator")
      sign_in user
      customer = FactoryBot.create(:customer)
      assignment = FactoryBot.create(:assignment)
      customer = assignment.customer
      expect {delete assignment_path(id: assignment.id)}.to change(Assignment, :count)
      expect(response).to redirect_to customer
     end
  end
end
