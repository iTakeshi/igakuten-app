class Staff < ActiveRecord::Base
  has_many :participations
  has_many :teams, through: :participations
  has_many :shifts, through: :participations
  has_many :periods, through: :shifts

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

  before_validation :set_verification_code, if: 'self.email_changed?'

  after_save :send_verification, if: 'self.email_changed?'

  after_create :participate_in_team_recess

  scope :ordered, -> { reorder('grade ASC, gender DESC, family_name_yomi ASC, given_name_yomi ASC') }

  def full_name
    "#{self.family_name} #{self.given_name}"
  end

  def full_name_yomi
    "#{self.family_name_yomi} #{self.given_name_yomi}"
  end

  def gender_to_s
    case self.gender
    when 1
      '男'
    when 0
      '女'
    end
  end

  def verificate(verification_code)
    if verification_code == self.email_verification_code
      self.email_verificated = true
      self.email_once_verificated = true
      self.save!
    end
  end

  def register
    self.provisional = false
    self.save!
  end

  def send_verification
    EmailVerificator.verification(self).deliver
  end

  private
  def set_verification_code
    self.email_verificated = false
    begin
      code = SecureRandom.hex(10)
    end while Staff.exists?(email_verification_code: code)
    self.email_verification_code = code
  end

  def participate_in_team_recess
    team_recess = Team.where(name: '休憩').first
    if team_recess
      self.teams << team_recess
    else
      puts 'WARNING: Team "休憩"が登録されていません'
    end
  end
end
