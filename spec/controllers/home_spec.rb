require 'rails_helper'

RSpec.describe HomeController do
  describe "GET #index" do
    subject { get :index }

    it "renders the application layout" do
      expect(subject).to render_template("layouts/application")
    end
	
    it "does not render a different layout" do
      expect(subject).to_not render_template("layouts/_header")
    end
  
    it "does not render a different template" do
      expect(subject).to_not render_template("home/about")
    end
  end
 end 