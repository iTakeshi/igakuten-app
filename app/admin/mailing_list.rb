ActiveAdmin.register MailingList do
  menu priority: 40

  permit_params %i(account_name)

  index do
    column :account_name
    column 'teams' do |ml|
      ml.teams.map(&:name).join(', ')
    end
    default_actions
  end

  show do
    attributes_table do
      row :account_name
      row 'teams' do |ml|
        ml.teams.map(&:name).join(', ')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :account_name
      f.input :teams,        as: :check_boxes
    end
    f.actions
  end

  controller do
    def create
      @mailing_list = MailingList.new(account_name: params[:mailing_list][:account_name])
      @mailing_list.teams = params[:mailing_list][:team_ids][1..-1].map { |id| Team.find(id) }
      super
    end

    def update
      @mailing_list = MailingList.find(params[:id])
      @mailing_list.teams = params[:mailing_list][:team_ids][1..-1].map { |id| Team.find(id) }
      super
    end
  end
end
