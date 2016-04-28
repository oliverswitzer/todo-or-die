require 'rails_helper'

describe GoalsController, type: :controller do

  describe "GET #new" do
    it "assigns a new goal" do
      get :new
      expect(assigns(:goal)).to be_a(Goal)
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    let(:goal_params) do
      FactoryGirl.attributes_for(:goal, name: 'test goal', word_count: 0)
    end

    it "creates a new goal with paramters" do
      post :create, goal: goal_params

      expect(assigns(:goal)).to have_attributes(name: 'test goal', word_count: 0)
    end

    it "returns http success" do
      post :create, goal: goal_params
      expect(response).to redirect_to(friends_path)
    end
  end
end
