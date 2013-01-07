# encoding: UTF-8
ActiveAdmin.register Participation, as: "Participation" do
  scope :all, default: true
  scope :unshared
  scope :shared
  scope "For friend", :friends
  scope :users

  filter :user, as: :select
  filter :person, as: :select
  filter :payment
  filter :owed_type, as: :check_boxes, collection: Participation.owed_type.options
  filter :owed_amount
  filter :owed_percent
  filter :debt
  filter :created_at

  index do
    column :bill, sortable: :bill_id
    column :user do |p|
      if p.user
        link_to p.user.display_name, admin_user_path(p.user)
      end
    end
    column :person, sortable: :person_id do |p|
      if p.person_id
        link_to p.person_id, admin_friend_path(p.person_id)
      end
    end
    column :payment, sortable: :payment do |p|
      number_to_currency p.payment
    end
    column :owed_type, sortable: :owed_type do |p|
      p.owed_type.text
    end
    column "Owed ¤", :owed_amount, sortable: :owed_amount do |p|
      number_to_currency p.owed_amount
    end
    column "Owed %", :owed_percent
    column :debt, sortable: :debt do |p|
      number_to_currency p.debt
    end
    column :created_at
    default_actions
  end
end

