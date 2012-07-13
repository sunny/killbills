# encoding: UTF-8
ActiveAdmin.register Participation do
  scope :all, default: true
  scope :unshared
  scope :shared
  scope "For friend", :friends
  scope :users

  filter :user, as: :select
  filter :person, as: :select
  filter :payment
  filter :owed, as: :check_boxes, collection: Participation.owed_for_select
  filter :owed_amount
  filter :owed_percent
  filter :debt
  filter :created_at

  index do
    column :bill, sortable: :bill_id
    column :user do |p|
      link_to p.user.display_name, [:admin, p.user]
    end
    column :person, sortable: :person_id do |p|
      link_to p.person.display_name, [:admin, p.person]
    end
    column :payment, sortable: :payment do |p|
      number_to_currency p.payment
    end
    column :owed
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

