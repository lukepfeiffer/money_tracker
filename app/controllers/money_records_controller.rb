class MoneyRecordsController < ApplicationController

  def create
    require 'pry'; binding.pry;
    money_record = MoneyRecord.new(money_record_params)
    money_record.category_id = params[:category_id]
    category = Category.find(params[:id])
    if money_record.save
      render partial: 'category_container', locals: {categories: category}
    else
      head :no_content
    end
  end

  private

  def money_record_params
    params.require(:money_record).permit(
      :amount,
      :category_id
    )
  end
end
