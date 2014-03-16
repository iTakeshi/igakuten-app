class MailingListArchivesController < ApplicationController
  # GET /mailing_list_archives.json
  def index
    # NOTE This action is DUMMY.
    # In order to register a URL (to which inbound-email API will be posted) to
    # Mandrill, GET request to the URL must be accepted.
    render json: { status: :ok }
  end

  # POST /mailing_list_archives.json
  def create
    message = ActiveSupport::JSON.decode(params['mandrill_events']).first['msg']

    unless mailing_list = MailingList.find_by(account_name: message['email'].split('@').first)
      # TODO notify sender
      render json: { status: :error }
      raise RuntimeError
    end
    unless staff = Staff.find_by(email: message['from_email'])
      # TODO notify sender
      render json: { status: :error }
      raise RuntimeError
    end
    subject = message['subject']
    body = message['text']
    raw_source = message['raw_msg']

    if messaage['attachments']
      # TODO notify sender
    end

    mla = MailingListArchive.new mailing_list: mailing_list,
                                 staff: staff,
                                 subject: subject,
                                 body: body,
                                 raw_source: raw_source
    if mla.save
      render json: { status: :ok }
      mla.publish
    else
      # TODO notify sender
      render json: { status: :error }
      raise RuntimeError
    end
  end
end
