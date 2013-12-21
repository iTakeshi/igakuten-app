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
    column '仮登録', :provisional_to_s
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
        staff.provisional_to_s
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

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

end
