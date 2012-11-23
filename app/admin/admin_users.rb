# encoding: UTF-8
ActiveAdmin.register AdminUser do
  menu priority: 20, label: "Administrator", parent: "Person"

  filter :email
  filter :created_at

  index do
    column :email
    column :created_at
    default_actions
  end
end

