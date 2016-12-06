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
      if category.money_records.present?
        records = category.money_records
      end
    else
      categories = user.categories.active
      categories.active.each do |category|
        category.money_records.where(created_at: start_date...end_date).each do |money_record|
          records << money_record
        end

      end
    end
    if records == []
      user.money_records.last
    else
      return records
    end
  end

end
