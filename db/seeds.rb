unless User.exists?(email: "test1@example.com")
  User.create!(
    email: "test1@example.com",
    password: "password",
    password_confirmation: "password",
    name: "テスト１"
  )
end

unless User.exists?(email: "test2@example.com")
  User.create!(
    email: "test2@example.com",
    password: "password",
    password_confirmation: "password",
    name: "テスト２"
  )
end
