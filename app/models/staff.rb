class Staff < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :shifts
  has_many :work_hours, through: :shifts, source: :periods
  has_many :unavailable_periods
  has_many :recesses, through: :unavailable_periods, source: :periods

  validates :family_name do
    presence
  end
  validates :family_name_yomi do
    presence
  end
  validates :given_name do
    presence
  end
  validates :given_name_yomi do
    presence
  end
  validates :grade do
    presence
    numericality only_integer: true,
                 greater_than_or_equal_to: 1,
                 less_than_or_equal_to: 6
  end
  validates :gender do
    presence
    numericality only_integer: true,
                 greater_than_or_equal_to: 0,
                 less_than_or_equal_to: 1
  end
  validates :phone do
    presence
    uniqueness
    format with: /\d{2,4}-\d{2,4}-\d{4}/
  end
  validates :email do
    presence
    uniqueness
    format with: /[^\s@]+@[^\s@]+/
  end
  validates :email_verification_code do
    presence
    uniqueness
  end

  before_validation :set_verification_code, on: :create

  after_create do
    EmailVerificator.verification(self).deliver
  end

  def full_name
    "#{self.family_name}#{self.given_name}"
  end

  def verificate_with(verification_code)
    if verification_code == self.email_verification_code
      self.email_verificated = true
      self.save!
    end
  end

  private

  def set_verification_code
    self.email_verificated = false
    begin
      code = SecureRandom.hex(10)
    end while Staff.exists?(email_verification_code: code)
    self.email_verification_code = code
  end
end
