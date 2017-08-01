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
    archived = false
    get_records_by_date(archived)
  end

  expose :archived_records_by_date do
    category = nil
    archived = true
    get_records_by_date(category, archived)
  end

  def index
  end

  def archived
  end

  def create
    amount = category.amount_from_params(params)
    category = Category.new(category_params)
    category.amount = amount

    respond_to do |format|
      format.js do
        if category.save
          category_service = Concerns::CategoryService.new(category.id, amount, current_user.paychecks.last)
          category_service.create_money_record
          category_service.update_paycheck if current_user.use_paycheck?
          flash[:notice] = 'Category was created!'
          flash.keep(:notice)
          render js: "window.location= '#{categories_path}'"
        else
          render partial: "shared/create_errors", locals: {model: category}
        end
      end
    end
  end

  def show
    category = Category.find(params[:id])
    if category.belongs_to?(current_user)
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
end
