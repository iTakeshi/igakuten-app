ActiveAdmin.register Staff do
  scope :ordered, default: true

  index do
    column :full_name
    column :full_name_yomi
    column :grade
    column :gender_to_s
    column :phone
    column :email
    column 'メールアドレス確認', :email_verificated_to_s
    column '仮登録', :provisional_to_s
  end

  show do
    attributes_table do
      row :full_name
      row :full_name_yomi
      row :grade
      row :gender_to_s
      row :phone
      row :email
      row 'メールアドレス確認', :email_verificated_to_s
      row '仮登録', :provisional_to_s
    end
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
