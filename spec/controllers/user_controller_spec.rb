require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "GET #name:string" do
    it "returns http success" do
      get :name:string
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #has_secure_password" do
    it "returns http success" do
      get :has_secure_password
      expect(response).to have_http_status(:success)
    end
  end

end
