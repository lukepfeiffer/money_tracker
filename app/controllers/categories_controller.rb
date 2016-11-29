class CategoriesController < ApplicationController
  expose :category
  expose :money_record

  expose :money_records do
    records = []
    records << current_user.money_records
    records
  end

  expose :active_records do
    records = []
    categories = current_user.categories.active
    categories.each do |c|
      records << c.money_records
    end
    records
  end

  expose :filtered_money_records do
    if params[:filter] == 'all'
      money_records
    elsif params[:filter] == 'active'
      active_records
    elsif params[:other] == 'other'
      filter_active_records
    end
  end

  expose :active_categories do
    current_user.categories.active.order(created_at: 'DESC')
  end
  expose :archived_categories do
    current_user.categories.archived.order(created_at: 'DESC')
  end

  def index
    if current_user.nil?
      redirect_to :root
    end
    @edit_link = true
  end

  def history
    if current_user.nil?
      redirect_to :root
    end
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
      render partial: 'category_container', locals: {categories: category}
    else
      head :no_content
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

  def filter_active_records
    records
    if params[:category_id].present?
      categories = current_user.categories.active
      categories.each do |c|
        c.money_records >> records
      end
    end
    require 'pry'; binding.pry;
    return records
  end

end
