require 'rails_helper'

describe Paycheck do

  describe '#adjust_amount_left' do
    let!(:user) { Fabricate(:user) }
    let!(:paycheck) { Fabricate(:paycheck, amount_left: 200, user_id: user.id) }
    let!(:added_amount) { 30 }

    it 'corectly adjusts amount left' do
      paycheck.adjust_amount_left(added_amount)
      expect(paycheck.amount_left).to eq(170)
    end
  end
end
