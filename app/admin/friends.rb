# encoding: UTF-8
ActiveAdmin.register Friend do
  filter :name
  filter :user, collection: lambda {
    User.all.map { |u| [u.title, u.id] }
  }
  filter :created_at, as: :date_range

  index do
    column :name
    column :user, sortable: :user_id do |friend|
      link_to friend.user.title, [:admin, friend.user]
    end
    column :created_at
    default_actions
  end
end

