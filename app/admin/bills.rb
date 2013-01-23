# encoding: UTF-8
ActiveAdmin.register Bill, as: "Bill" do
  filter :user
  filter :friend_id
  filter :title
  filter :user_ratio
  filter :date

  index do
    column :user, sortable: :user_id do |bill|
      if bill.user
        link_to bill.user.display_name, admin_user_path(bill.user)
      end
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

