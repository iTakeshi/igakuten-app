class EmailVerificator < ActionMailer::Base
  default from: 'staff@hokudai-igakuten.org'

  def verification(staff)
    @staff = staff
    mail to: @staff.email, subject: '医学展スタッフ仮登録'
  end
end
