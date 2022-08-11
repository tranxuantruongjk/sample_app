class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
    length: {maximum: Settings.validates.name_max_length}

  validates :email, presence: true,
    length: {maximum: Settings.validates.email_max_length},
    format: {with: Settings.validates.email_regex},
    uniqueness: {case_sentitive: false}

  validates :password, presence: true,
    length: {minimum: Settings.validates.password_min_length}

  has_secure_password

  private
  def downcase_email
    email.downcase!
  end

  # Returns the hash digest of the given string.
  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end
  end
end
