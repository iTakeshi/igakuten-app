class Staff < ActiveRecord::Base
  has_many :participations, dependent: :destroy
  has_many :teams, through: :participations
  has_many :shifts, through: :participations
  has_many :periods, through: :shifts

  attr_accessor :by_invitation

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

  before_validation :set_verification_code, if: 'self.email_changed?', unless: 'self.by_invitation'

  after_save :send_verification, if: 'self.email_changed?', unless: 'self.by_invitation'

  after_create :callback_after_create

  scope :ordered, -> { reorder('grade ASC, gender DESC, family_name_yomi ASC, given_name_yomi ASC') }

  def Staff.new_by_invitation(staff_params)
    staff = Staff.new(staff_params)
    staff.set_verification_code
    staff.provisional = true
    staff.email_verificated = true
    staff.email_once_verificated = true
    staff.by_invitation = true
    staff
  end

  def initialize(attributes = {}, options = {})
    super
    @by_invitation = false
  end

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

  def set_verification_code
    self.email_verificated = false
    begin
      code = SecureRandom.hex(10)
    end while Staff.exists?(email_verification_code: code)
    self.email_verification_code = code
  end

  def notify_shifts
    shifts = self.shifts
    ordered_shifts = Period.ordered.map { |p|
      shifts.find_by(period_id: p.id)
    }.compact

    compacted_shifts = []
    skip_until = 0
    for i in 0..(ordered_shifts.length - 1)
      next if i < skip_until

      breaked = false
      i_tmp = i
      for j in (i + 1)..(ordered_shifts.length - 1)
        a = ordered_shifts[i_tmp]
        b = ordered_shifts[j]
        if a.participation != b.participation || a.period.ends_at != b.period.begins_at
          breaked = true
          break
        end
        i_tmp = j
      end
      j += 1 if j == ordered_shifts.length - 1 && !breaked
      skip_until = j

      compacted_shifts << [ordered_shifts[i].period.begins_at, ordered_shifts[j - 1].period.ends_at, ordered_shifts[i].participation.team.name]

    end

    ShiftNotifier.notification(self, compacted_shifts).deliver
  end

  private

  def callback_after_create
    participate_in_team_recess
    search_invitation
  end

  def participate_in_team_recess
    team_recess = Team.where(name: '休憩').first
    if team_recess
      self.teams << team_recess
    else
      puts 'WARNING: Team "休憩"が登録されていません'
    end
  end

  def search_invitation
    if invitation = Invitation.find_by(email: self.email)
      invitation.accepted = true
      invitation.save!
    end
  end
end
