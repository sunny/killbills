# encoding: UTF-8
ActiveAdmin.register User do
  filter :email
  filter :name
  filter :sign_in_count
  filter :last_sign_in_at, :as => :date_range
  filter :created_at, :as => :date_range

  index do
    column :email
    column :name
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    default_actions
  end
end

