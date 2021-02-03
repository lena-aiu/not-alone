require 'rails_helper'

RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
end #lo cambie a spec_helper.rb

RSpec.describe "Videos", type: :request do
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

  describe "get videos_path" do
    it "renders the index view" do
      service = FactoryBot.create_list(:video, 10)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      #sign_in user
      get videos_path
      expect(response.status).to eq(200)
    end
  end

  describe "get video_path" do
    it "renders the :show template" do
      video = FactoryBot.create(:video)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      #sign_in user
      #service GET    /videos/:id(.:format)
      get video_path(id: video.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the video id is invalid" do
      get video_path(id: 5000) #an ID that doesn't exist
      expect(response).to be_redirect
    end
  end

  describe "get new_video_path" do
    it "renders the :new template" do
      video = FactoryBot.create(:video)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      get new_video_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "get new_video_path" do
    it "renders the :new template  redirects to the index path if the the user role is invalid" do
      video = FactoryBot.create(:video)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "stranger")
      sign_in user
      get new_video_path
      # expect(user.role).to_not eq("administrator")
      # expect(response.status).to eq(200)
      expect(response).to_not render_template(:new)
    end
  end

  describe "get edit_video_path" do
    it "renders the :edit template" do
      video = FactoryBot.create(:video)
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      get edit_video_path(id: video.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the video id is invalid" do
      get video_path(id: 5000) #an ID that doesn't exist
      expect(response).to be_redirect
    end
  end
  #POST       /videos(.:format)
  describe "post videos_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      video_attributes = FactoryBot.attributes_for(:video)
      expect { post videos_path, params: {video: video_attributes}
    }.to change(Video, :count)
      expect(response).to redirect_to video_path(id: Video.last.id)
    end
  end

  describe "post videos_path with invalid data" do
    it "does not save a new entry or redirect" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      video_attributes = FactoryBot.attributes_for(:video)
      video_attributes.delete(:title)
      expect { post videos_path, params: {video: video_attributes}
    }.to_not change(Video, :count)
      expect(response.status).to eq(200)
    end
  end

  describe "put video_path with valid data" do
    it "updates an entry and redirects to the show path for the video" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      video = FactoryBot.create(:video) #create or build
      put video_path(id: video.id), params: {video: {title: "new", description: "new", text: "new"}}
      video.reload
      expect(video.title).to eq("new")
      expect(response).to redirect_to video_path(id: video.id)
    end
  end

  describe "put video_path with invalid data" do
    it "updates an entry and redirects to the show path for the video" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      video = FactoryBot.create(:video) #create or build
      put video_path(id: video.id), params: {video: {title: "", description: "", text: ""}}
      video.reload
      expect(video.title).to_not eq("nil")
      expect(response.status).to eq(200)
    end
  end

  describe "delete a video record" do
    it "deletes a video record" do
      user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
      sign_in user
      video = FactoryBot.create(:video)
      delete video_path(id: video.id), params: {video:{title: "new", description: "new", text: "new"}}
#     #expect(response).to have_http_status(:success)
      # expect { delete videos_path(id: video.id).to eq("new")}
      # expect(response).to redirect_to video_path(id: video.id)
      expect(response).to redirect_to videos_path
     end
  end
end
