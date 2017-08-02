class Concerns::CategoryService
  attr_reader :paycheck, :category_id, :user
  attr_accessor :amount

  def initialize(category_id, amount, paycheck)
    @category_id = category_id
    @user = Category.find(category_id).user
    @amount = amount.present? ? amount : 0
    @paycheck = paycheck if @user.use_paycheck?
  end

  def update_categories_amount
    date = paycheck.date_received.present? ? paycheck.date_received : Date.today
    user.categories.active.each_with_object( [] ) do |category, amounts|
      cat_amount = paycheck.amount * (category.paycheck_percentage/100)
      category.update(amount: category.amount + cat_amount)
      MoneyRecord.create(amount: amount, category_id: category.id, description: "From paycheck", adjusted_date: date)
      self.amount += cat_amount
    end

    update_paycheck if user.use_paycheck?
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
