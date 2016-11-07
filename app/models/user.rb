class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :email
  validates_uniqueness_of :email, on: :create

  def encrypt_password
    if password.present?
      require 'pry'; binding.pry;
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = Bcrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
