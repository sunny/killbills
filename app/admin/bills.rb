# encoding: UTF-8
ActiveAdmin.register Bill do
  filter :user, collection: lambda {
    User.all.map { |u| [u.title, u.id] }
  }
  filter :friend_id
  filter :title
  filter :user_ratio
  filter :date

  index do
    column :user, sortable: :user_id do |bill|
      link_to bill.user.title, [:admin, bill.user]
    end
    column :title
    column :total do |bill|
      number_to_currency bill.total
    end
    column :date
    column :created_at
    default_actions
  end
end

