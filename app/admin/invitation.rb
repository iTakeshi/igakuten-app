ActiveAdmin.register Invitation do
  menu priority: 11

  permit_params %i(email)

  actions :all, except: %i(show edit update)

  index do
    column :email
    column '招待メール再送' do |invitation|
      link_to '招待メール再送', send_invitation_admin_invitation_path(invitation)
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :email, as: :email
    end
    f.actions
  end

  member_action :send_invitation, method: :get do
    invitation = Invitation.find(params[:id])
    invitation.send_invitation_mail
    redirect_to admin_invitations_path, notice: '招待メールを再送しました。'
  end

  controller do
    def create
      create! do |format|
        format.html { redirect_to new_admin_invitation_path }
      end
    end
  end
end
