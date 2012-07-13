# encoding: UTF-8
ActiveAdmin.register User do
  filter :email
  filter :name
  filter :sign_in_count
  filter :last_sign_in_at, as: :date_range
  filter :created_at, as: :date_range

  index do
    column :email
    column :name
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    default_actions
  end

  show do |user|
    attributes_table do
      row :email
      row :name
      row :created_at
      row :updated_at
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :bills do
        link_to "#{user.bills.count} Bills", admin_bills_path(q:{ user_id_eq: 878662715})
      end
    end

    active_admin_comments
  end
end

