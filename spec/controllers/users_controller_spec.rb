require 'rails_helper'

describe UsersController do

  describe "#confirm_email" do
    let(:confirmation_token) { "some_token" }
    let!(:user) { Fabricate(:unconfirmed_user, confirm_token: confirmation_token) }
    it 'confirms email' do
      get :confirm_email, {token: confirmation_token}
      expect(User.last.confirmed_email).to be true
    end
  end

  describe "#create" do
    let(:parameters) { { user: { email: "email@example.com", password: "password", password_confirmation: "password" } } }
    it 'sends email on create' do
      get :create, parameters

      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.subject).to eq("Registration Confirmation")
    end
  end
end
