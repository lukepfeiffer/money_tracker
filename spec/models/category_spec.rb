require 'rails_helper'

describe Category do

  describe "#adjust_amount_left" do
    let!(:user) { Fabricate(:user) }
    let!(:category) { Fabricate(:category, amount: 200, user_id: user.id) }
    let(:added_amount) { 30 }

    it 'updates category with new amount' do
      category.adjust_amount(added_amount)
      expect(category.amount).to eq(230)
    end
  end

  describe "#belongs_to?" do
    let(:user1) { Fabricate(:user) }
    let(:user2) { Fabricate(:user, email: "email@example2.com") }
    let(:category) { Fabricate(:category, user_id: user1.id) }

    it 'returns true' do
      actual = category.belongs_to?(user1)
      expect(actual).to be true
    end

    it 'returns false' do
      actual = category.belongs_to?(user2)
      expect(actual).to be false
    end
  end

  describe '#amount_from_params' do
    context 'paycheck user' do
      let!(:user) { Fabricate(:paycheck_user) }
      let!(:category) { Fabricate(:category, paycheck_percentage: 25, user_id: user.id) }
      let!(:paycheck) { Fabricate(:paycheck, amount: 100, user_id: user.id) }
      let(:params) { { category: {paycheck_percentage: category.paycheck_percentage} } }

      it 'returns correct amount' do
        amount = category.amount_from_params(params)
        expected_amount = paycheck.amount * (0.25)
        expect(amount).to eq(expected_amount)
      end
    end

    context 'non_paycheck_user' do
      let!(:user) { Fabricate(:user) }
      let!(:category) { Fabricate(:category, user_id: user.id) }
      let!(:params) { { category: {amount: 200.22} } }

      it 'returns correct amount for non-paycheck user' do
        amount = category.amount_from_params(params)
        expected_amount = params[:category][:amount]
        expect(amount).to eq(expected_amount)
      end
    end
  end

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

  describe '#percent_too_high' do
    let!(:user) { Fabricate(:paycheck_user) }
    context "percent is too high" do
      let!(:category1) { Fabricate(:paycheck_category, user_id: user.id, paycheck_percentage: 30) }
      let!(:category2) { Fabricate(:paycheck_category, user_id: user.id, paycheck_percentage: 30) }
      let!(:category3) { Fabricate(:paycheck_category, user_id: user.id, paycheck_percentage: 30) }

      it 'returns true' do
        new_category = Category.new(user_id: user.id, paycheck_percentage: 30)
        actual = new_category.percent_too_high?
        expect(actual).to be true
      end
    end

    context "percent is not too high" do
      let!(:category1) { Fabricate(:paycheck_category, user_id: user.id, paycheck_percentage: 30) }
      let!(:category2) { Fabricate(:paycheck_category, user_id: user.id, paycheck_percentage: 30) }

      it 'returns false' do
        new_category = Category.new(user_id: user.id, paycheck_percentage: 30)
        actual = new_category.percent_too_high?
        expect(actual).to be false
      end
    end
  end
end
