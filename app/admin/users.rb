# encoding: UTF-8
ActiveAdmin.register User, as: "User" do
  menu parent: "People", priority: 1

  scope :users, default: true

  filter :email
  filter :name
  filter :sign_in_count
  filter :last_sign_in_at, as: :date_range
  filter :created_at, as: :date_range

  index as: :table do |user|
    column :email
    column :bills do |guest|
      link_to pluralize(guest.bills.count, "Bill"), admin_bills_path(q: { user_id_eq: guest })
    end
    column "Signed in", :sign_in_count
    column :last_sign_in_at
    column :created_at
    default_actions
  end

  show do |user|
    attributes_table do
      row :email
      row :type
      row :bills do
        link_to pluralize(user.bills.count, "Bill"), admin_bills_path(q:{ user_id_eq: user.id })
      end
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
    end

    active_admin_comments
  end
end

