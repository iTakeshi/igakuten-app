ActiveAdmin.register Period do
  belongs_to :festival_date

  scope :ordered, default: true

  permit_params %i(festival_date_id begins_at ends_at)

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
end
