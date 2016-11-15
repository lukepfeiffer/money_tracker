class CategoriesController < ApplicationController
  expose :category
  expose :categories do
    current_user.categories
  end
end
