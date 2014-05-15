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

    unless staff = Staff.find_by(email: message['from_email'])
      MlError.from_not_found(message['from_email']).deliver
      render json: { status: :ok }
      return
    end
    unless mailing_list = MailingList.find_by(account_name: message['email'].split('@').first)
      MlError.ml_not_found(staff, message['email']).deliver
      render json: { status: :ok }
      return
    end

    unless subject = message['subject']
      subject = '無題'
    end
    subject = "【医学展】 #{subject}"
    body = message['text']
    raw_source = message['raw_msg']

    if message['attachments']
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
