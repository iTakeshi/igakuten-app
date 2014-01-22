ActiveAdmin.register FestivalDate do
  menu priority: 30

  scope :ordered, default: true

  permit_params %i(day date)

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
end
