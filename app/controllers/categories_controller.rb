class CategoriesController < ApplicationController
  expose :money_record
  expose :category
  expose :paycheck

  expose :active_categories do
    current_user.categories.active
  end

  expose :archived_categories do
    current_user.categories.archived
  end

  expose :active_records_by_date do
    get_records_by_date
  end

  expose :archived_records_by_date do
    get_records_by_date(nil, true)
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

    respond_to do |format|
      format.js do
        if category.save
          MoneyRecord.create(
            amount: amount, category_id:
            category.id, adjusted_date: DateTime.now,
            description: "Intitial category creation"
          )
          flash[:notice] = 'Category was created!'
          flash.keep(:notice)
          render js: "window.location= '#{categories_path}'"
        else
          render partial: "create_errors", locals: {category: category}
        end
      end
    end
  end

  def show
    category = Category.find(params[:id])
    if belongs_to_current_user(category)
      get_records_by_date = get_records_by_date(category)
      render partial: 'category_table', locals: {records_by_date: get_records_by_date}
    else
      redirect_to categories_path(notice: "You do not have access!")
    end
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
  def category_params
    params.require(:category).permit(
      :name,
      :amount,
      :user_id,
      :description,
      :paycheck_percentage
    )
  end

  def belongs_to_current_user(category)
    category.user_id == current_user.id ? true : false
  end

  def get_money_record_amount
    if params[:category][:paycheck_percentage].present?
      current_user.paychecks.last.amount * (params[:category][:paycheck_percentage].to_d/100)
    else
      params[:category][:amount]
    end
  end

end
