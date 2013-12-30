ActiveAdmin.register Section do
  scope :ordered, default: true

  permit_params %i(name display_order)

  index do
    column :name
    column :display_order
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :display_order
    end
  end
end
