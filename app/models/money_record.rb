class MoneyRecord < ActiveRecord::Base
  belongs_to :category

  def self.sum(records)
    sum = 0
    records.each do |record|
      if record.amount.present?
        sum = sum + record.amount
      end
    end
    return sum
  end

  def self.filter(user, start_date, end_date, category)
    records = []
    if category.present?
      records << category.money_records.where(created_at: start_date...end_date)
      return records
    else
      category = user.categories.active
      category.active.each do |category|
        category.money_records.where(created_at: start_date...end_date).each do |money_record|
          records << money_record
        end
      end
      return records
    end
  end

end
