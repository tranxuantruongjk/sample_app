require 'faker'
# Create a main sample user.
User.create!(name: "Xuan Truong",
             email: "xuantruonghy823@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             admin: true)

for n in 0..99
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end
