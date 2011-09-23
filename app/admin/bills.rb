ActiveAdmin.register Bill do
  #filter :user
  #filter :friend
  filter :title
  filter :amount
  filter :user_ratio
  filter :date

  index do
    column :user, :sortable => :user_id do |bill|
      link_to bill.user.email, [:admin, bill.user]
    end
    column :friend, :sortable => :friend_id
    column :title
    column :amount
    column :user_ratio
    column :date
    column :created_at
    default_actions
  end
end

