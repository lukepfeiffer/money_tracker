class Category < ActiveRecord::Base
  belongs_to :category

  scope :active, -> {where(archived_at: nil)}
  scope :archived, -> {where.not(archived_at: nil)}

end
