ActiveAdmin.register Staff do
  scope :ordered, default: true

  permit_params %i(family_name family_name_yomi given_name given_name_yomi grade gender phone email provisional)

  index do
    column :full_name
    column :full_name_yomi
    column :grade
    column :gender_to_s
    column :phone
    column :email
    column 'メールアドレス確認', :email_verificated_to_s
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
        staff.email_verificated_to_s
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

  member_action :register, method: :get do
    staff = Staff.find(params[:id])
    staff.register
    redirect_to({ action: :index }, { notice: "#{staff.full_name}さんを本登録しました。" })
  end
end
