require 'spec_helper'

describe 'user' do
  let(:pw) { Faker::Lorem.characters 6 }

  it 'creates and logs in' do
    visit '/'
    find('.navbar-inner a.btn-navbar').click
    click_link 'Sign up'
    fill_in 'user_name', with: Faker::Name.name
    fill_in 'user_email', with: Faker::Internet.email
    fill_in 'user_password', with: pw
    fill_in 'user_password_confirmation', with: pw
    click_button 'Sign up'
    page.should have_content 'Welcome! You have signed up successfully'
  end

  it 'edits user' do
    @user = User.create! name: Faker::Name.name, email: Faker::Internet.email, password: pw, password_confirmation: pw
    sign_in @user
    find('.navbar-inner a.btn-navbar').click
    click_link 'Edit account'
    page.should have_content 'Edit User'
  end
end
