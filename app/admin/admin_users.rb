ActiveAdmin.register AdminUser do
  filter :email
  filter :created_at

  index do
    column :email
    column :created_at
    default_actions
  end
end

