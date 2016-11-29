class CategoriesController < ApplicationController

  expose :category
  expose :money_record

  def index
    if current_user.nil?
      redirect_to :root
    end
    @edit_link = true
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

end
