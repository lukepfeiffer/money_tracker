class PaychecksController < ApplicationController
  def create
    paycheck = Paycheck.new(paycheck_params)
    paycheck.user_id = current_user.id

    if paycheck.save
      update_categories_amounts(paycheck.amount, paycheck.date_received)
      redirect_to categories_path(notice: "Paycheck created!")
    else
      redirect_to categories_path(notice: "Paycheck could not be saved")
    end
  end

  private

  def paycheck_params
    params.require(:paycheck).permit(
      :amount,
      :date_received
    )
  end

  def update_categories_amounts(paycheck_amount, paycheck_date)
    date = paycheck_date.present? ? paycheck_date : Date.today
    current_user.categories.active.each do |category|
      amount = paycheck_amount * (category.paycheck_percentage/100)
      category.update(amount: category.amount + amount)
      MoneyRecord.create(amount: amount, category_id: category.id, description: "From paycheck", adjusted_date: date)
    end
  end
end
