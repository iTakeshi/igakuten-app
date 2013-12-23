class EmailVerificator < ActionMailer::Base
  default from: 'staff@hokudai-igakuten.org'

  def verification(staff)
    @staff = staff
    if staff.email_once_verificated
      subject = '【医学展】登録メールアドレス変更'
      template = :verification_update
    elsif staff.provisional
      subject = '【医学展】スタッフ仮登録完了'
      template = :verification_new_provisional
    else
      subject = '【医学展】スタッフ登録完了'
      template = :verification_new_registrant
    end
    mail to: @staff.email, subject: subject, template_name: template
  end
end
