require 'rails_helper'

describe Category do

  describe "#validate" do
    context "#validate paycheck percentage when user is set to use paychecks" do
      let!(:user) { Fabricate(:paycheck_user) }

      it 'returns an error' do
        category =  Category.new(name: "Category", description: "Description", user_id: user.id)
        expect(category.save).to be false
        expect(category.errors.messages[:paycheck_percentage]).to include("Must have a paycheck percentage!")
      end

      it 'saves correctly' do
        category =  Category.new(name: "Category", description: "Description", user_id: user.id, paycheck_percentage: "30")
        expect(category.save).to be true
      end
    end
  end

  context '#active' do
    let(:user) { Fabricate(:user) }
    let(:archived) {Fabricate(:archived_category, user_id: user.id)}
    let(:active) {Fabricate(:category, user_id: user.id)}

    it 'returns active categories' do
      actual = Category.all.active
      expect(actual).to include(active)
      expect(actual).to_not include(archived)
    end

    it 'returns archived categories' do
      actual = Category.all.archived
      expect(actual).to include(archived)
      expect(actual).to_not include(active)
    end

    it 'returns true for active category' do
      expect(active.active?).to be true
    end

    it 'returns false for archived category' do
      expect(archived.active?).to be false
    end
  end
end
