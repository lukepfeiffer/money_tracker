class PaychecksController < ApplicationController
  def create
    paycheck = Paycheck.new(paycheck_params)
    paycheck.user_id = current_user.id

    if paycheck.save
      update_categories_amounts(paycheck.amount)
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

  def update_categories_amounts(paycheck_amount)
    current_user.categories.each do |category|
      category.update(amount: paycheck_amount * (category.paycheck_percentage/100))
    end
  end
end
