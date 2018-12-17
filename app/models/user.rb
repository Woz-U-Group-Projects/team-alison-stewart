require 'digest/sha1'

class User < ActiveRecord::Base
  # Constants
  ROLES = %w[admin teacher].freeze

  # Associations
  has_many :comments, as: :owner, dependent: :destroy
  belongs_to :school

  # Attributes
  attr_accessor :password, :password_confirmation

  # Validations
  validates_presence_of     :email
  validates_length_of       :email, within: 6..100
  validates_uniqueness_of   :email, case_sensitive: false
  validates_format_of       :email, with: RegexHelper::EMAIL
  validates_presence_of     :password,                   if: :password_required?
  validates_presence_of     :password_confirmation,      if: :password_required?
  validates_length_of       :password, within: 4..40,    if: :password_required?
  validates_confirmation_of :password,                   if: :password_required?
  validates_inclusion_of    :role, in: ROLES

  # Callbacks
  before_save :encrypt_password

  # Class methods
  def self.authenticate(email, password)
    user = where(email: email).first

    user && user.authenticated?(password) ? user : nil
  end

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Instance methods
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token = encrypt("#{email}--#{remember_token_expires_at}")

    save(validate: false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token = nil

    save(validate: false)
  end

  def is?(role_type)
    role == role_type.to_s
  end

  protected

  def password_required?
    crypted_password.blank? || !password.blank?
  end

  def encrypt_password
    return if password.blank?

    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
    self.crypted_password = encrypt(password)
  end
end
