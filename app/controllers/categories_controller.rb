class CategoriesController < ApplicationController

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

  def belongs_to_current_user(category)
    category.user_id == current_user.id ? true : false
  end

  def get_records_by_date(category = nil, archived = false)
    if category.present?
      dates = category.money_records.map(&:adjusted_date).uniq.sort.reverse
      category_ids = category.id
    elsif archived
      dates = current_user.get_money_records_dates(archived)
      category_ids = archived_categories.map(&:id)
    else
      dates = current_user.get_money_records_dates
      category_ids = active_categories.map(&:id)
    end

    dates = dates.uniq.sort.reverse

    dates.each_with_object( [] ) do |date, records|
      records << MoneyRecord.where(adjusted_date: date, category_id: category_ids)
    end
  end

  def get_money_record_amount
    if params[:category][:paycheck_percentage].present?
      current_user.paychecks.last.amount * params[:category][:paycheck_percentage].to_d
    else
      params[:category][:amount]
    end
  end

end
