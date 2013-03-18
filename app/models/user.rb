class User < ActiveRecord::Base
  rolify
  validates_presence_of :user_name
  validates_uniqueness_of :user_name, :email, case_sensitive: false
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_name,
    :first_name, :last_name
  attr_accessible :role_ids, as: :admin
  attr_accessible :role_names, as: :admin

  attr_protected :created_at, :updated_at

  def as_json(options = {})
    super(options || {}).merge({role_names: role_names})
  end

  def role_names
    self.roles.map(&:name).join(',')
  end

  def role_names= new_roles
    self.roles.destroy_all
    new_roles.split(',').each do |new_role|
      self.add_role new_role.to_sym
    end
  end
end
