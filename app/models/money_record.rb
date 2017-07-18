class MoneyRecord < ActiveRecord::Base
  belongs_to :category

  def self.sum(records)
    records.inject(0) { |sum, r| r.amount.nil? ? sum + 0 : sum + r.amount }
  end

  def self.filter(user, start_date, end_date, category)
    records = []

    if category.present?
      records = category.money_records.where(adjusted_date: start_date...end_date)
    else
      categories = user.categories.active

      categories.active.each do |category|
        category.money_records.where(adjusted_date: start_date...end_date).each do |money_record|
          records << money_record
        end
      end

    end

    records
  end

end
