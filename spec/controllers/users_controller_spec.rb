require 'spec_helper'

describe UsersController do
    let(:user) do
      User.create! user_name: "test", email: "test@example.com", first_name: "John",
        last_name: "Doe", password: '123456', password_confirmation: '123456', role_names: 'not'
    end

    let(:admin_user) do
      User.create! user_name: "admin", email: "admin@example.com", first_name: "John",
        last_name: "Doe", password: '123456', password_confirmation: '123456', role_names: 'admin,not'
    end
  context 'index' do
    it 'redirects to root unless logged in' do
      get :index
      response.should redirect_to '/users/sign_in'
    end

    it 'redirects to root unless admin' do
      sign_in user
      get :index
      response.should redirect_to :root
    end

    it 'does not redirect if admin' do
      sign_in admin_user
      get :index
      response.should_not redirect_to :root
    end

    it 'instantiates @users' do
      sign_in admin_user
      get :index
      assigns(:users)
    end
  end

  context 'update' do
    it 'redirects to root unless admin' do
      sign_in user
      put :update, id: 1
      response.should redirect_to :root
    end

    it 'updates user' do
      sign_in admin_user
      put :update, id: user.id, user: {first_name: 'new_name'}
      user.reload.first_name.should eq 'new_name'
    end
  end
end
