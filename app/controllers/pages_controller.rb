class PagesController < ApplicationController

  expose :user

  def home
    if current_user.present?
      redirect_to categories_path
    else
      redirect_to new_session_path
    end
  end

  def contact
  end

end
