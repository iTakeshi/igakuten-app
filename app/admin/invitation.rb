ActiveAdmin.register Invitation do
  menu priority: 11

  permit_params %i(email)

  index do
    column :email
  end

  form do |f|
    f.inputs do
      f.input :email, as: :email
    end
    f.actions
  end

  controller do
    def create
      create! do |format|
        format.html { redirect_to admin_invitations_path }
      end
    end
  end
end