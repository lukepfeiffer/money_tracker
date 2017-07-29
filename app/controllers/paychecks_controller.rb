class PaychecksController < ApplicationController
  def create
    paycheck = Paycheck.new(paycheck_params)
    paycheck.user_id = current_user.id
    paycheck.amount_left = params[:paycheck][:amount]
    category_id = current_user.categories.active.first.id

    if paycheck.save
      category_service = Concerns::CategoryService.new(category_id, nil, paycheck)
      category_service.update_categories_amount
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
end
