class CategoriesController < ApplicationController

  expose :category
  expose :paycheck

  expose :active_categories do
    current_user.categories.active
  end

  expose :archived_categories do
    current_user.categories.archived
  end

  expose :records_by_date do
    dates = current_user.money_records.map(&:adjusted_date).uniq.sort.reverse
    category_ids = current_user.categories.map(&:id)

    dates.each_with_object( [] ) do |date, records|
      records << MoneyRecord.where(adjusted_date: date, category_id: category_ids)
    end

  end

  def example
  end

  def index
  end

  def archived
  end

  def create
    amount = get_money_record_amount
    category = Category.new(category_params)
    category.amount = amount
    category.user_id = current_user.id

    if category.save
      MoneyRecord.create(
        amount: amount, category_id:
        category.id, adjusted_date: DateTime.now,
        description: "Intitial category creation"
      )
      redirect_to categories_path(notice: "Category was created!")
    else
      render :index
    end
  end

  def category_params
    params.require(:category).permit(
      :name,
      :amount,
      :user_id,
      :description,
      :paycheck_percentage
    )
  end

  def unarchive
    category = Category.find(params[:id])
    category.update(archived_at: nil)
    head :no_content
  end

  def destroy
    category = Category.find(params[:id])
    category.update(archived_at: DateTime.now)
    head :no_content
  end

  private

  def get_money_record_amount
    if params[:category][:paycheck_percentage].present?
      current_user.paychecks.last.amount * params[:category][:paycheck_percentage].to_d
    else
      params[:category][:amount]
    end
  end

end
