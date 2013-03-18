namespace :seeder do
  desc 'Seed database with "n" users'
  task :seed, [:count] => :environment do |t,args|
    args[:count] ||= 10
    if Rails && Rails.env == "development"
      User.create! user_name: "admin", email: "admin@example.com", first_name: "admin",
        last_name: "user", password: '123456', password_confirmation: '123456', role_names: 'admin'
      (1..args[:count].to_i).each do |n|
        User.create! user_name: "test #{n}", email: "a#{n}@a.com", first_name: "John #{n}",
          last_name: "Doe #{n}", password: '123456', password_confirmation: '123456'
      end
    end
  end
end
