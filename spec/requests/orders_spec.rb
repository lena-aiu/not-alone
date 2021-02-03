require 'rails_helper'

# RSpec.configure do |config|
#   config.include DeviseRequestSpecHelpers, type: :request
# end #lo cambie a spec_helper.rb

RSpec.describe "Orders", type: :request do
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
    #POST       /videos(.:format)
    describe "post orders_path with valid data" do
      it "saves a new entry and redirects to the show path for the entry" do
        user = User.create(email: 'test@icloud.com', password: "password", password_confirmation: "password", role: "administrator")
        sign_in user
        customer = FactoryBot.create(:customer)
        service = FactoryBot.create(:service)
        expect { post orders_path, params: {order: {customer_id: customer.id, service_id: service.id} }
      }.to change(Order, :count)
        expect(response).to redirect_to order_path(id: Order.last.id)
      end
    end

end
