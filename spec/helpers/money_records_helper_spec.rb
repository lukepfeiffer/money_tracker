require 'rails_helper'

describe MoneyRecordsHelper do
  let(:negative_record) {Fabricate(:money_record, amount: -10.00)}
  let(:positive_record) {Fabricate(:money_record, amount: 10.00)}

  describe '#is_negative?' do
    it 'returns true' do
      expect(helper.is_negative?(negative_record)).to eq(true)
    end

    it 'returns false' do
      expect(helper.is_negative?(positive_record)).to eq(false)
    end
  end
end
