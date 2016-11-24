class CategoriesController < ApplicationController
  expose :category
  expose :money_record
  expose :active_categories do
    current_user.categories.active
  end

  def index
  end

  def new
  end

  def create
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

  def destroy
    category = Category.find(params[:id])
    category.update(archived_at: DateTime.now)
    head :no_content
  end

end
