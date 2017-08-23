class Category < ActiveRecord::Base
  belongs_to :user
  has_many :money_records

  scope :active, -> {where(archived_at: nil)}
  scope :archived, -> {where.not(archived_at: nil)}

  validate :validate_paycheck_percentage, on: :create
  validates_presence_of :name, :user_id

  def validate_paycheck_percentage
    if user.use_paycheck? && user.auto_populate?
      errors.add(:paycheck_percentage, "Must be greater than 0!") if nil_or_less_than_zero?
      errors.add(:paycheck_percentage, "All active categories percents can not be more than 100!") if self.percent_too_high?
    end
  end

  def reset_cycle
    update(
          amount: 0,
          cycle_date: cycle_date + 1.month
    )
  end

  def active?
    archived_at == nil ? true : false
  end

  def percent_too_high?
      categories = user.categories.active
      (categories.sum(:paycheck_percentage).to_i + self.paycheck_percentage) > 100
  end

  def belongs_to?(user)
    user_id == user.id ? true : false
  end

  def amount_from_params(params)
    if params[:category][:paycheck_percentage].present?
      user.paychecks.last.amount * (params[:category][:paycheck_percentage].to_d/100)
    else
      params[:category][:amount]
    end
  end

  def adjust_amount(added_amount)
    update(amount: amount + added_amount)
  end

  private

  def nil_or_less_than_zero?
    paycheck_percentage.nil? || paycheck_percentage < 1
  end
end
