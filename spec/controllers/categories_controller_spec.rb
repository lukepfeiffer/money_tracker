require 'rails_helper'

describe CategoriesController, type: :controller do
  describe 'Archiving' do
    let(:user) { Fabricate(:user) }
    let(:archived_category) { Fabricate(:archived_category, user_id: user.id) }
    let(:active_category) { Fabricate(:category, user_id: user.id) }

    it 'unarchives category' do
      get :unarchive, {id: archived_category.id }
      expect(Category.last.archived_at).to eq(nil)
    end

    it 'archives category' do
      get :destroy, {id: active_category.id }
      expect(Category.last.archived_at).to be_truthy
    end
  end
end
