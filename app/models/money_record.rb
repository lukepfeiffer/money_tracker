class MoneyRecord < ActiveRecord::Base
  belongs_to :category

  def self.sum(records)
    sum = 0
    records.first.each do |record|
      if record.amount.present?
        sum = sum + record.amount
      end
    end
    return sum
  end
end
