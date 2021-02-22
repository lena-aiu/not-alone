require 'rails_helper'

RSpec.configure do |config|
    config.include DeviseRequestSpecHelpers, type: :request
  end

RSpec.describe "Categories", type: :request do
    describe "sign in" do
      it "signs user in and out" do
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        get root_path
        expect(response).to render_template(:index)
      end
    end
  
    describe "get categories_path" do
      it "renders the index view" do
        category = FactoryBot.create_list(:category, 10)
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        get categories_path
        expect(response.status).to render_template(:index)
      end
    end
  
    describe "get category_path" do
      it "renders the :show template" do
        category = FactoryBot.create(:category)
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        get category_path(id: category.id)
        expect(response.status).to render_template(:show)
      end
      it "renders the :show template - redirects to the index path if the category id is invalid" do
        category = FactoryBot.create(:category)
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        get category_path(id: 5000)
        expect(response).to redirect_to categories_path
      end
    end
  
    describe "get new_category_path" do
      it "renders the :new template" do
        category = FactoryBot.create(:category)
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        get new_category_path
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end
  
    describe "get new_category_path" do
      it "renders the :new template - redirects to the index path if the the user role is invalid" do
        category = FactoryBot.create(:category)
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "stranger")
        sign_in user
        get new_category_path
        expect(response).to_not render_template(:new)
      end
    end
  
    describe "get edit_category_path" do
      it "renders the :edit template" do
        category = FactoryBot.create(:category)
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        get edit_category_path(id: category.id)
        expect(response.status).to render_template(:edit)
      end
      it "renders the :edit template - redirects to the index path if the category id is invalid" do
        get category_path(id: 5000)
        expect(response).to redirect_to categories_path
      end
    end
  
    describe "post categories_path with valid data" do
      it "saves a new entry and redirects to the show path for the category" do
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        category_attributes = FactoryBot.attributes_for(:category)
        expect { post categories_path, params: {category: category_attributes}
      }.to change(Category, :count)
        expect(response).to redirect_to category_path(id: Category.last.id)
      end
    end
  
    describe "post categories_path with invalid data" do
      it "does not save a new entry and redirects to the show path for the category" do
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        category_attributes = FactoryBot.attributes_for(:category)
        category_attributes.delete(:name)
        expect { post categories_path, params: {category: category_attributes}
      }.to_not change(Category, :count)
        expect(response.status).to render_template(:new)
      end
    end
  
    describe "put category_path with valid data" do
      it "updates an entry and redirects to the show path for the category" do
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        category = FactoryBot.create(:category)
        put category_path(id: category.id), params: {category: {name: "new", description: "new", text: "new"}}
        category.reload
        expect(category.name).to eq("new")
        expect(response).to redirect_to category_path(id: category.id)
      end
    end
  
    describe "put category_path with invalid data" do
      it "updates an entry and redirects to the edit path for the category" do
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        category = FactoryBot.create(:category)
        put category_path(id: category.id), params: {category: {name: "", description: "", text: ""}}
        category.reload
        expect(category.name).to_not eq("nil")
        expect(response.status).to render_template(:edit)
      end
    end
  
    describe "delete a category record" do
      it "deletes a category record and redirects to the index path" do
        user = User.create(email: 'test@icloud.com', password: "Pa$$word20", password_confirmation: "Pa$$word20", role: "administrator")
        sign_in user
        category = FactoryBot.create(:category)
        delete category_path(id: category.id), params: {category: {name: "new", description: "new", text: "new"}}
        expect(response).to redirect_to categories_path
       end
    end
  end
