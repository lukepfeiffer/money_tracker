class Paycheck < ActiveRecord::Base
  belongs_to :user

  def adjust_amount_left(added_amount)
    update(amount_left: amount_left - added_amount)
  end
end
