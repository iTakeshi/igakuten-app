ActiveAdmin.register Team do
  belongs_to :section

  config.sort_order = 'display_order_asc'

  controller do
    def scoped_collection
      super.includes :section
    end
  end

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
