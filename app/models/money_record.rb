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

  def self.filter(user, start_date, end_date, category)
    records = []
    if params[:category_id].present?
      # categories = current_user.categories.active
      # categories.each do |c|
      #   records << c.money_records
      # end
    elsif params[:start_date].present?
    elsif params[:end_date].present?
    end
    records
  end

end
