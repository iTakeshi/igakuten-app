ActiveAdmin.register Section do
  config.sort_order = 'display_order_asc'

  index do
    column :name
    column :display_order
    column 'Teams' do |section|
      link_to 'Teams', admin_section_teams_path(section)
    end
    default_actions
  end

  show do
    attributes_table do
      row :name
      row 'Teams' do |section|
        link_to 'Teams', admin_section_teams_path(section)
      end
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
