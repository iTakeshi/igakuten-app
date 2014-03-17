class StaffInvitor < ActionMailer::Base
  default from: 'staff@hokudai-igakuten.org'

  def invitation(model)
    @model = model
    mail to: model.email, subject: '【医学展】スタッフ招待'
  end
end
