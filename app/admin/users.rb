ActiveAdmin.register User do

  filter :email
  index do
    column :email, :sortable => :email do |user|
      link_to user.email, admin_user_path(user)
    end
    column :name, :sortable => false
  end

  show do
    h3 user.email
    div do
      simple_format [user.name]
    end
    div do
      simple_format ["Created at", user.created_at.to_s(:long)].join(': ')
    end
    div do
      simple_format ["Updated at", user.created_at.to_s(:long)].join(': ')
    end
    div do
      simple_format ["Cell Phone", user.cell_phone].join(': ')
    end
    div do
      simple_format ["Home Phone", user.home_phone].join(': ')
    end
    div do
      simple_format ["Work Phone", user.work_phone].join(': ')
    end
  end

  index do
    column :name
    column :email
    column "Actions" do |q|
      link_to 'Show', admin_user_path(q)
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :cell_phone
      f.input :work_phone
      f.input :home_phone
    end
    f.buttons
  end
end
