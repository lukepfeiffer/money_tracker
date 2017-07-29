class Concerns::CategoryService
  attr_reader :paycheck, :amount, :category_id, :user

  def initialize(category_id, amount, paycheck)
    @category_id = category_id
    @user = Category.find(category_id).user
    @amount = amount
    @paycheck = paycheck if @user.use_paycheck?
  end

  def update_categories_amount
    date = paycheck.date_received.present? ? paycheck.date_received : Date.today
    user.categories.active.each do |category|
      amount = paycheck.amount * (category.paycheck_percentage/100)
      category.update(amount: category.amount + amount)
      MoneyRecord.create(amount: amount, category_id: category.id, description: "From paycheck", adjusted_date: date)
    end
  end

  def create_money_record
    MoneyRecord.create(
      amount: amount, category_id: category_id,
      adjusted_date: Date.today, description: "Initial category creation"
    )
  end

  def update_paycheck
    paycheck.update(amount_left: paycheck.amount_left - amount)
  end
end
