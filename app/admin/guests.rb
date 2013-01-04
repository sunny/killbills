# encoding: UTF-8
ActiveAdmin.register Guest, as: "Guest" do
  menu parent: "People", priority: 2

  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  index do
    column :created_at
    column :updated_at
    column :bills do |guest|
      link_to pluralize(guest.bills.count, "Bill"), admin_bills_path(q: { user_id_eq: guest })
    end
    default_actions
  end

  show do |guest|
    attributes_table do
      row :created_at
      row :updated_at
      row :last_sign_in_at
      row :last_sign_in_ip
      row :bills do
        link_to pluralize(guest.bills.count, "Bill"), admin_bills_path(q: { user_id_eq: guest })
      end
    end

    active_admin_comments
  end
end

