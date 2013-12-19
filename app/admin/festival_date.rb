ActiveAdmin.register FestivalDate do
  config.sort_order = 'day asc'

  index do
    column :day
    column :date
    column 'Periods' do |fd|
      link_to 'Periods', admin_festival_date_periods_path(fd)
    end
    default_actions
  end

  show do
    attributes_table do
      row :day
      row :date
      row 'Periods' do |fd|
        link_to 'Periods', admin_festival_date_periods_path(fd)
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
