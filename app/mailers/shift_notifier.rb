class ShiftNotifier < ActionMailer::Base
  default from: "staff@hokudai-igakuten.org"

  def notification(staff, shifts)
    @staff = staff
    @shifts = shifts

    mail to: staff.email, subject: '【医学展】シフト確認'
  end
end
