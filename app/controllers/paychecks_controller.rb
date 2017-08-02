class PaychecksController < ApplicationController
  def create
    paycheck = Paycheck.new(paycheck_params)
    paycheck.user_id = current_user.id
    paycheck.amount_left = params[:paycheck][:amount]
    category_id = current_user.categories.active.first.id

    if paycheck.save
      category_service = Concerns::CategoryService.new(category_id, nil, paycheck)
      category_service.update_categories_amount
      flash[:success] = "Paycheck created!"
      redirect_to categories_path
    else
      flash[:danger] = "Paycheck could not be saved"
      redirect_to categories_path
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
