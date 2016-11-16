class CategoriesController < ApplicationController
  expose :category
  expose :categories do
    current_user.categories
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

  def show
  end

end
