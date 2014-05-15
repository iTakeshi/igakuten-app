ActiveAdmin.register Team do
  menu priority: 21

  scope :ordered, default: true

  permit_params %i(section_id name display_order)

  index do
    column :section
    column :name
    column :display_order
    column 'スタッフ数' do |team|
      team.staffs.length
    end
    column '目標' do |team|
      (team.quorums.map(&:quorum).reduce(&:+).to_f / 3).ceil
    end
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
