ActiveAdmin.register Bill do
  #filter :user
  #filter :friend
  filter :title
  filter :amount
  filter :user_ratio
  filter :date

  index do
    column :user
    column :friend
    column :title
    column :amount
    column :user_ratio
    column :date
    column :created_at
    default_actions
  end
end

