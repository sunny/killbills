ActiveAdmin.register User do
  filter :name
  filter :email
  filter :created_at

  index do
    column :name
    column :email
    column :created_at
    default_actions
  end
end

