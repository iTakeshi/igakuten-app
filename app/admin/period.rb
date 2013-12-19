ActiveAdmin.register Period do
  belongs_to :festival_date

  config.sort_order = 'begins_at asc'

  controller do
    def scoped_collection
      super.includes :festival_date
    end
  end

  index do
    column :festival_date
    column :begins_at
    column :ends_at
    default_actions
  end

  show do
    attributes_table do
      row :festival_date
      row :begins_at
      row :ends_at
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
