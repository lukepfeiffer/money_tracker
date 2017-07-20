module CategoriesHelper
  def is_negative?(amount)
    if amount.present?
      amount < 0 ? true : false
    end
  end
end
