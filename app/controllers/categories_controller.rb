class CategoriesController < ApplicationController

  expose :category
  expose :money_record
  expose :active_categories do
    current_user.categories.active
  end
  expose :archived_categories do
    current_user.categories.archived
  end

  expose :money_records do
    current_user.money_records.first(10)
  end

  expose :records_by_date do
    records = []
    dates = current_user.money_records.map(&:adjusted_date).uniq.sort.reverse
    category_ids = current_user.categories.map(&:id)

    dates.each do |date|
      records << MoneyRecord.where(adjusted_date: date, category_id: category_ids)
    end

    records

  end

  def example
    @archive_link = true
  end

  def index
    if current_user.nil?
      redirect_to :root
    end
    @archive_link = true
  end

  def archived
    if current_user.nil?
      redirect_to :root
    end
    @edit_link = false
  end

  def create
    if current_user.nil?
      redirect_to :root
    end
    category = Category.new(category_params)
    category.user_id = current_user.id
    if category.save
      MoneyRecord.create(amount: category.amount, category_id: category.id, adjusted_date: DateTime.now, description: "Intitial category creation")
      redirect_to categories_path
    else
      render :index
    end
  end

  def category_params
    params.require(:category).permit(
      :name,
      :amount,
      :user_id,
      :description
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

end
