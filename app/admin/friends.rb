ActiveAdmin.register Friend do
  filter :name
  #filter :user

  index do
    column :name
    column :user, :sortable => :user_id do |friend|
      link_to friend.user.email, [:admin, friend.user]
    end
    column :created_at
    default_actions
  end
end

