class Category < ActiveRecord::Base
  belongs_to :user
  has_many :money_records

  scope :active, -> {where(archived_at: nil)}
  scope :archived, -> {where.not(archived_at: nil)}

  validate :validate_paycheck_percentage
  validates_presence_of :name, :user_id

  def validate_paycheck_percentage
    if user.use_paycheck? && paycheck_percentage == nil
      errors.add(:paycheck_percentage, "Must have a paycheck percentage!")
    end
  end
end
