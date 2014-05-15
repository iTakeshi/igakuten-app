class MlError < ActionMailer::Base
  default from: 'staff@hokudai-igakuten.org'

  def from_not_found(from_email)
    @from_email = from_email
    mail to: from_email, subject: '【医学展】MLの送信に失敗しました'
  end

  def ml_not_found(staff, email)
    @staff = staff
    @email = email
    mail to: staff.email, subject: '【医学展】MLの送信に失敗しました'
  end
end
