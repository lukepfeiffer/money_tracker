class User < ActiveRecord::Base
  attr_accessor :password

  has_many :categories
  has_many :money_records, through: :categories
  has_many :paychecks

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

  def get_money_records_dates(archived = false)
    filtered_categories = archived ? categories.archived : categories.active

    filtered_categories.each_with_object([]) do |category, dates|
      category.money_records.each do |record|
        dates << record.adjusted_date
      end
    end

  end

  def total_money
    transactions = categories.active.each_with_object([]) do |category, records|
      category.money_records.each do |record|
        records << record
      end
    end

    MoneyRecord.sum(transactions)
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
