ActiveAdmin.register Staff do
  menu priority: 10

  scope :ordered, default: true

  permit_params %i(family_name family_name_yomi given_name given_name_yomi grade gender phone email provisional)

  index do
    column :full_name
    column :full_name_yomi
    column :grade
    column :gender_to_s
    column :phone
    column :email
    column 'メールアドレス確認' do |staff|
      "未確認：#{link_to '確認メール再送', send_verification_admin_staff_path(staff)}".html_safe unless staff.email_verificated
    end
    column '仮登録' do |staff|
      "仮：#{link_to '本登録する', register_admin_staff_path(staff)}".html_safe if staff.provisional
    end
    default_actions
  end

  show do
    attributes_table do
      row :full_name
      row :full_name_yomi
      row :grade
      row :gender_to_s
      row :phone
      row :email
      row 'メールアドレス確認' do |staff|
        "未確認：#{link_to '確認メール再送', send_verification_admin_staff_path(staff)}".html_safe unless staff.email_verificated
      end
      row '仮登録' do |staff|
        "仮：#{link_to '本登録する', register_admin_staff_path(staff)}".html_safe if staff.provisional
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :family_name
      f.input :family_name_yomi
      f.input :given_name
      f.input :given_name_yomi
      f.input :grade,            as: :select, collection: 1..6
      f.input :gender,           as: :select, collection: { '男' => 1, '女' => 0 }
      f.input :phone
      f.input :email
      f.input :provisional
    end
    f.actions
  end

  action_item only: :index do
    link_to('Invite staff', new_invitation_admin_staffs_path)
  end

  collection_action :new_invitation, method: :get do
    @invitation = Invitation.new
  end

  collection_action :create_invitation, method: :post do
    @invitation = Invitation.new(email: params[:invitation][:email])

    if @invitation.save
      redirect_to({ action: :new_invitation }, { notice: "#{@invitation.email}さんに招待メールを送信しました。" })
    else
      flash.now[:alert] = 'メールアドレスの形式が不正です。招待を送信できません。'
      render action: :new_invitation
    end
  end

  member_action :register, method: :get do
    staff = Staff.find(params[:id])
    staff.register
    redirect_to({ action: :index }, { notice: "#{staff.full_name}さんを本登録しました。" })
  end

  member_action :send_verification, method: :get do
    staff = Staff.find(params[:id])
    staff.send_verification
    redirect_to({ action: :index }, { notice: "#{staff.full_name}さんに確認メールを再送しました。" })
  end
end
