require 'rails_helper'

describe CategoriesHelper do
  let(:negative_record) {Fabricate(:money_record, amount: -10.00)}
  let(:positive_record) {Fabricate(:money_record, amount: 10.00)}

  describe '#is_negative_amount?' do
    it 'returns true' do
      expect(helper.is_negative_amount?(negative_record)).to eq(true)
    end

    it 'returns false' do
      expect(helper.is_negative_amount?(positive_record)).to eq(false)
    end
  end

  describe 'fields' do
    context 'user uses paychecks for budgeting' do
      let(:user) { Fabricate(:paycheck_user) }
      it 'returns correct label' do
        form_for(Category.new) do |f|
          label = helper.amount_label(f, true)
          expect(label).to eq("<label for=\"category_paycheck_percentage\">Paycheck percentage</label>")
        end
      end

      it 'returns correct field' do
        form_for(Category.new) do |f|
          field = helper.amount_field(f, true)
          expect(field).to eq("<input class=\"number-field\" step=\"0.01\" placeholder=\"25.00\" type=\"number\" name=\"category[paycheck_percentage]\" id=\"category_paycheck_percentage\" />")
        end
      end
    end

    context 'User does not use paychecks' do
      let(:user) { Fabricate(:user) }

      it 'returns correct label' do
        form_for(Category.new) do |f|
          label = helper.amount_label(f, false)
          expect(label).to eq("<label for=\"category_amount\">Amount</label>")
        end
      end

      it 'returns correct field' do
        form_for(Category.new) do |f|
          field = helper.amount_field(f, false)
          expect(field).to eq("<input class=\"number-field\" step=\"0.01\" placeholder=\"60.00\" type=\"number\" name=\"category[amount]\" id=\"category_amount\" />")
        end
      end
    end
  end
end
