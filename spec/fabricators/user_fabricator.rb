Fabricator :user do
  email 'email@example.com'
  password 'password'
end

Fabricator(:paycheck_user, from: :user) do
  use_paycheck true
end
