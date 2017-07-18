require 'rails_helper'

describe MoneyRecord do
  context 'Sum amounts of money records' do
    let(:pos_record_one) {Fabricate(:money_record, amount: 22.11)}
    let(:pos_record_two) {Fabricate(:money_record, amount: 133.00)}
    let(:neg_record_one) {Fabricate(:money_record, amount: -44.93)}
    let(:neg_record_two) {Fabricate(:money_record, amount: -83.16)}
    let(:nil_record) {Fabricate(:money_record, amount: nil)}

    it 'returns sums with all negative amounts' do
      records = [neg_record_one, neg_record_two]
      expect(MoneyRecord.sum(records)).to eq(-128.09)
    end

    it 'returns sums with all positive amounts' do
      records = [pos_record_one, pos_record_two]
      expect(MoneyRecord.sum(records)).to eq(155.11)
    end

    it 'returns sums with positive and negative amounts' do
      records = [neg_record_one, neg_record_two, pos_record_one, pos_record_two]
      expect(MoneyRecord.sum(records)).to eq(27.02)
    end

    it 'handles a nil amount' do
      records = [neg_record_one, neg_record_two, nil_record]
      expect(MoneyRecord.sum(records)).to eq(-128.09)
    end
  end

  context 'Filter money records' do
    let!(:user1) {Fabricate(:user)}
    let!(:category_one) {Fabricate(:category, user_id: user1.id, name: "Category One")}
    let!(:category_two) {Fabricate(:category, user_id: user1.id, name: "Category Two")}

    let!(:c1_record_one) {Fabricate(:money_record, category_id: category_one.id, amount: 10)}
    let!(:c1_record_two) {Fabricate(:money_record, category_id: category_one.id, amount: 20)}
    let!(:c2_record_one) {Fabricate(:money_record, category_id: category_two.id, amount: 30)}
    let!(:c2_record_two) {Fabricate(:money_record, category_id: category_two.id, amount: 40)}

    let!(:old_record_one) {Fabricate(:money_record, category_id: category_one.id, adjusted_date: (DateTime.now - 1.month) )}
    let!(:old_record_two) {Fabricate(:money_record, category_id: category_two.id, adjusted_date: (DateTime.now - 1.month) )}

    let!(:new_record_one) {Fabricate(:money_record, category_id: category_one.id, adjusted_date: (DateTime.now + 1.month) )}
    let!(:new_record_two) {Fabricate(:money_record, category_id: category_two.id, adjusted_date: (DateTime.now + 1.month) )}

    let!(:user2) {Fabricate(:user, email: "user2@example.com")}
    let!(:user_two_category) {Fabricate(:category, name: "User two category", user_id: user2.id)}
    let!(:user_two_record) {Fabricate(:money_record, category_id: user_two_category.id, amount: 50)}

    it 'returns records for user' do
      actual_records = MoneyRecord.filter(user1, Date.today-1.year, Date.tomorrow, nil)
      expect(actual_records).to include(c1_record_one)
      expect(actual_records).to include(c1_record_two)
      expect(actual_records).to include(c2_record_one)
      expect(actual_records).to include(c2_record_two)
      expect(actual_records).to include(old_record_one)
      expect(actual_records).to include(old_record_two)
      expect(actual_records).to_not include(user_two_category)
    end

    it 'returns records based on start date' do
      actual_records = MoneyRecord.filter(user1, Date.today-1.week, Date.tomorrow, nil)
      expect(actual_records).to include(c1_record_one)
      expect(actual_records).to include(c1_record_two)
      expect(actual_records).to include(c2_record_one)
      expect(actual_records).to include(c2_record_two)
      expect(actual_records).to_not include(new_record_one)
      expect(actual_records).to_not include(new_record_two)
      expect(actual_records).to_not include(old_record_one)
      expect(actual_records).to_not include(old_record_two)
      expect(actual_records).to_not include(user_two_category)
    end

    it 'returns records based on end date' do
      actual_records = MoneyRecord.filter(user1, Date.today-1.week, Date.tomorrow, nil)
      expect(actual_records).to include(c1_record_one)
      expect(actual_records).to include(c1_record_two)
      expect(actual_records).to include(c2_record_one)
      expect(actual_records).to include(c2_record_two)
      expect(actual_records).to_not include(new_record_one)
      expect(actual_records).to_not include(new_record_two)
      expect(actual_records).to_not include(old_record_one)
      expect(actual_records).to_not include(old_record_two)
      expect(actual_records).to_not include(user_two_category)
    end

    it 'returns records based on category' do
      actual_records = MoneyRecord.filter(user1, Date.today - 1.year, Date.today + 1.year, category_one)
      expect(actual_records).to include(c1_record_one)
      expect(actual_records).to include(c1_record_two)
      expect(actual_records).to include(new_record_one)
      expect(actual_records).to include(old_record_one)
      expect(actual_records).to_not include(new_record_two)
      expect(actual_records).to_not include(old_record_two)
      expect(actual_records).to_not include(c2_record_one)
      expect(actual_records).to_not include(c2_record_two)
      expect(actual_records).to_not include(user_two_category)
    end

    # Not currently working
    xit 'returns records based on start date, end date, and category' do
      actual_records = MoneyRecord.filter(user1, Date.today - 1.week, Date.today + 1.week, category_one)
      expect(actual_records).to include(c1_record_one)
      expect(actual_records).to include(c1_record_two)
      expect(actual_records).to_not include(new_record_one)
      expect(actual_records).to_not include(old_record_one)
      expect(actual_records).to_not include(new_record_two)
      expect(actual_records).to_not include(old_record_two)
      expect(actual_records).to_not include(c2_record_one)
      expect(actual_records).to_not include(c2_record_two)
      expect(actual_records).to_not include(user_two_category)
    end
  end
end
