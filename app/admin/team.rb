ActiveAdmin.register Team do
  scope :ordered, default: true

  index do
    column :section
    column :name
    column :display_order
    default_actions
  end

  show do
    attributes_table do
      row :section
      row :name
      row :display_order
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