ActiveAdmin.register Friend do
  filter :name
  #filter :user

  index do
    column :name
    column :user
    column :created_at
    default_actions
  end
end

