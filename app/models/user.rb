class User < ActiveRecord::Base
  attr_accessor :password

  has_many :categories
  has_many :money_records, through: :categories

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email, on: :create

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def total_money
    records = []

    categories.each do |category|
      category.money_records.each do |record|
        records << record
      end
    end

    MoneyRecord.sum(records)
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
