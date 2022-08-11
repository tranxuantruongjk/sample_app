class User < ApplicationRecord
  attr_accessor :remember_token

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

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Returns a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  private
  def downcase_email
    email.downcase!
  end
end
