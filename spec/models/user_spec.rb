require 'rails_helper'

describe User do
  describe "#get_money_records_dates" do
    let!(:user) { Fabricate(:user) }
    let!(:active_category) { Fabricate(:category, user_id: user.id) }
    let!(:archived_category) { Fabricate(:archived_category, user_id: user.id) }
    let!(:active_record) { Fabricate(:money_record, adjusted_date: Date.yesterday, category_id: active_category.id) }
    let!(:archived_record) { Fabricate(:money_record, adjusted_date: Date.tomorrow, category_id: archived_category.id) }

    context "#archived" do
      it 'returns the archived records dates' do
        actual = user.get_money_records_dates(true)
        expect(actual).to include(archived_record.adjusted_date)
        expect(actual).to_not include(active_record.adjusted_date)
      end
    end

    context "active" do
      it 'returns active records dates' do
        actual = user.get_money_records_dates
        expect(actual).to include(active_record.adjusted_date)
        expect(actual).to_not include(archived_record.adjusted_date)
      end
    end
  end
end
