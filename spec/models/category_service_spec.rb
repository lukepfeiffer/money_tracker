require 'rails_helper'

describe Concerns::CategoryService do
  let(:user) { Fabricate(:user) }
  let(:category) { Fabricate(:category, user_id: user.id) }
  let(:paycheck_user) { Fabricate(:paycheck_user) }
  let(:paycheck_category) { Fabricate(:category, user_id: paycheck_user.id, paycheck_percentage: 25) }
  let(:paycheck) { Fabricate(:paycheck, user_id: paycheck_user.id, amount: 500, amount_left: 475, date_received: Date.yesterday) }
  let(:amount) { 25.00 }

  describe '#create_money_record' do
    it 'creates money_record' do
      category_service = described_class.new(category.id, amount, nil)
      money_records = category_service.create_money_record
      expect(money_records.amount.to_i).to eq(25)
    end
  end

  describe '#update_paycheck' do
    it 'updates paycheck if current_user uses paychecks' do
      category_service = described_class.new(paycheck_category.id, amount, paycheck)
      category_service.update_paycheck(25)
      expect(paycheck.amount_left.to_i).to eq(450)
    end
  end
end
