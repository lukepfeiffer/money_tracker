class Category < ActiveRecord::Base
  belongs_to :user
  has_many :money_records

  scope :active, -> {where(archived_at: nil)}
  scope :archived, -> {where.not(archived_at: nil)}

  validate :validate_paycheck_percentage, on: :create
  validates_presence_of :name, :user_id

  def validate_paycheck_percentage
    if user.use_paycheck?
      errors.add(:paycheck_percentage, "Must have a paycheck percentage!") if paycheck_percentage == nil
      errors.add(:paycheck_percentage, "Must be greater than 0!") if nil_or_less_than_zero?
      errors.add(:paycheck_percentage, "All active categories percents can not be more than 100!") if percent_too_high
    end
  end

  def active?
    archived_at == nil ? true : false
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

  private

  def nil_or_less_than_zero?
    paycheck_percentage.nil? || paycheck_percentage < 1
  end

  def percent_too_high
    unless nil_or_less_than_zero?
      categories = user.categories.active
      (categories.sum(:paycheck_percentage).to_i + self.paycheck_percentage) > 100
    end
  end
end
