Fabricator :user do
  email 'email@example.com'
  password 'password'
  confirmed_email true
end

Fabricator(:paycheck_user_no_autopopulate, from: :user) do
  use_paycheck true
  auto_populate false
end

Fabricator(:unconfirmed_user, from: :user) do
  confirmed_email false
end


Fabricator(:paycheck_user, from: :user) do
  use_paycheck true
  auto_populate true
end
