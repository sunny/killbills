# encoding: UTF-8
ActiveAdmin.register AdminUser, as: "Administrator" do
  menu priority: 20, parent: "People"

  filter :email
  filter :created_at

  index do
    column :email
    column :bills do |guest|
      link_to pluralize(guest.bills.count, "Bill"), admin_bills_path(q: { user_id_eq: guest })
    end
    column "Signed in", :sign_in_count
    column :last_sign_in_at
    column :created_at
    default_actions
  end
end

