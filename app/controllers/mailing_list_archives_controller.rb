class MailingListArchivesController < ApplicationController
  # POST /mailing_list_archives.json
  def create
    message = ActiveSupport::JSON.decode(params['mandrill_events'])['msg']

    unless mailing_list = MailingList.find(account_name: message['email'])
      # TODO notify sender
      render json: { status: :error }
      raise RuntimeError
    end
    unless staff = Staff.find(email: message['from_email'])
      # TODO notify sender
      render json: { status: :error }
      raise RuntimeError
    end
    subject = message['subject']
    body = message['text']

    mla = MailingListArchive.new mailing_list: mailing_list,
                                 staff: staff,
                                 subject: subject,
                                 body: body
    if mla.save
      render json: { status: :ok }
    else
      # TODO notify sender
      render json: { status: :error }
      raise RuntimeError
    end
  end
end
