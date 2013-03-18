require 'spec_helper'

describe User do

  context '.as_json' do
    it 'has role_names key' do
      User.new.as_json.should have_key :role_names
    end
  end

  context '.role_names' do
    let (:user) do
      User.create! user_name: "test", email: "test@example.com", first_name: "John",
        last_name: "Doe", password: '123456', password_confirmation: '123456', role_names: 'admin,not'
    end

    it 'gets' do
      user.role_names.should eq 'admin,not'

    end

    it 'sets' do
      user
      roles = user.roles.map(&:name)
      roles.should include 'admin'
      roles.should include 'not'
    end
  end
end
