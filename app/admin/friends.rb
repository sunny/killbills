# encoding: UTF-8
ActiveAdmin.register Friend do
  menu priority: 15

  filter :name
  filter :user
  filter :created_at, as: :date_range

  index do
    column :name
    column :user, sortable: :user_id do |friend|
      link_to friend.user.display_name, [:admin, friend.user]
    end
    column :created_at
    default_actions
  end
end

