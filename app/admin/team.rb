ActiveAdmin.register Team do
  scope :ordered, default: true

  permit_params %i(section_id name display_order)

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
end
