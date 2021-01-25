require 'rails_helper'

RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
end #lo cambie a spec_helper.rb

RSpec.describe "Videos", type: :request do
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

  describe "get videos_path" do  
    it "renders the index view" do
      service = FactoryBot.create_list(:video, 10)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password") 
      sign_in user 
      get videos_path
      expect(response.status).to eq(200)
    end
  end 

  describe "get video_path" do
    it "renders the :show template" do
      video = FactoryBot.create(:video)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      #service GET    /videos/:id(.:format)  
      get video_path(id: video.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the service id is invalid" do
      get video_path(id: 5000) #an ID that doesn't exist
      expect(response).to be_redirect
    end
  end

  describe "get new_video_path" do
    it "renders the :new template" do
      video = FactoryBot.create(:video)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      get new_video_path 
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "get edit_video_path" do
    it "renders the :edit template" do
      video = FactoryBot.create(:video)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      get edit_video_path(id: video.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the customer id is invalid" do
      get video_path(id: 5000) #an ID that doesn't exist
      expect(response).to be_redirect
    end  
  end
  #POST       /videos(.:format)                                                               
  describe "post videos_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do   
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password")
      sign_in user
      video_attributes = FactoryBot.attributes_for(:video)
      expect { post videos_path, params: {video: video_attributes}
    }.to change(Video, :count)
      expect(response).to redirect_to video_path(id: Video.last.id)
    end
  end


end