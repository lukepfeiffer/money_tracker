class MoneyRecordsController < ApplicationController

  expose :category
  expose :money_record

  def create
    money_record = MoneyRecord.new(money_record_params)
    money_record.category_id = params[:category_id]
    category = Category.find(params[:category_id])
    adjust_category_amount(category, money_record)
    if money_record.save
      render partial: 'categories/category_container', locals: {categories: category}
    else
      head :no_content
    end
  end

  def adjust_category_amount(category, money_record)
    category.update(amount: category.amount + money_record.amount)
  end

  private

  def money_record_params
    params.require(:money_record).permit(
      :amount,
      :category_id
    )
  end
end
