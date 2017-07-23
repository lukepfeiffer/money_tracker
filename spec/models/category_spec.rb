require 'rails_helper'

describe Category do

  describe "#validate" do
    let!(:user) { Fabricate(:paycheck_user) }

    context "#validate paycheck percentage when user is set to use paychecks" do

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

    context "#validate paycheck_percentages of active categories is less than 100" do
      it 'returns an error' do
        category =  Category.new(name: "Category", description: "Description", user_id: user.id, paycheck_percentage: "199")
        expect(category.save).to be false
        expect(category.errors.messages[:paycheck_percentage]).to include("All active categories percents can not be more than 100!")
      end

      it 'returns an error' do
        category =  Category.new(name: "Category", description: "Description", user_id: user.id, paycheck_percentage: "0")
        expect(category.save).to be false
        expect(category.errors.messages[:paycheck_percentage]).to include("Must be greater than 0!")
      end

      it 'returns an error' do
        Category.create(name: "Category", description: "Description", user_id: user.id, paycheck_percentage: "30")
        Category.create(name: "Category", description: "Description", user_id: user.id, paycheck_percentage: "30")
        Category.create(name: "Category", description: "Description", user_id: user.id, paycheck_percentage: "30")
        category = Category.new(name: "Category", description: "Description", user_id: user.id, paycheck_percentage: "30")
        expect(category.save).to be false
        expect(category.errors.messages[:paycheck_percentage]).to include("All active categories percents can not be more than 100!")
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
