Fabricator :user do
  email 'email@example.com'
  password 'password'
  confirmed_email true
end

Fabricator(:paycheck_user, from: :user) do
  use_paycheck true
end
