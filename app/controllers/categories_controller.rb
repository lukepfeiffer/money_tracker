class CategoriesController < ApplicationController
  expose :category
  expose :money_record
  expose :active_categories do
    current_user.categories.active.order(created_at: 'DESC')
  end
  expose :archived_categories do
    current_user.categories.archived.order(created_at: 'DESC')
  end

  def index
    @edit_link = true
  end

  def new
  end

  def archived
    @edit_link = false
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
