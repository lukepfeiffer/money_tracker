class CategoriesController < ApplicationController
  expose :categories do
    current_user.categories
  end
end
