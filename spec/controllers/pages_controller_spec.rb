require 'rails_helper'

describe PagesController, type: :controller do

  describe '#email_admin' do
    let(:email_subject) { "This is the subject" }
    let(:from) { "email@example.com" }
    let(:body) { "This is the body" }
    let(:permitted_params) { { user: {from: from, body: body, subject: email_subject } } }
    let(:invalid_params) { { user: {body: body, subject: email_subject } } }

    context 'from and body present' do
      it 'sends email' do
        post :email_admin, permitted_params
        last_email = ActionMailer::Base.deliveries.last
        expect(flash[:notice]).to eq("Successfully sent email!")
        expect(last_email.subject).to eq(email_subject)
      end
    end

    context 'from and body not present' do
      it 'does not send email' do
        ActionMailer::Base.deliveries = []
        post :email_admin, invalid_params
        last_email = ActionMailer::Base.deliveries.last
        expect(flash[:danger]).to eq("Something went wrong...")
        expect(last_email).to be_falsey
      end
    end
  end
end
