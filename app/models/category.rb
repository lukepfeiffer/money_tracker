class Category < ActiveRecord::Base
  belongs_to :user
  has_many :money_records

  scope :active, -> {where(archived_at: nil)}
  scope :archived, -> {where.not(archived_at: nil)}

end
