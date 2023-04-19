require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #index" do
    # pending "add some examples (or delete) #{__FILE__}"
    it "renders users index" do
      get :index 
      expect(response).to render_template(:index)
    end

  end

  describe "GET #show" do
    it "renders users show" do
      test_user = FactoryBot.create(:user)
      get :show, params: { id: test_user.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "brings up the form to make a new user" do
      allow(subject).to receive(:logged_in?).and_return(true)

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    before :each do
      create(:user)
      allow(subject).to receive(:current_user).and_return(User.last)
    end

    let(:valid_params) { { user: { username: current_user.username, password: "password"} } }
  end
end
