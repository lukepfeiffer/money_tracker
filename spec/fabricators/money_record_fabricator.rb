Fabricator :money_record do
  adjusted_date DateTime.now
  amount "50.44"
end

Fabricator(:archived_money_record, from: :money_record) do
  adjusted_date DateTime.now
  amount "30.88"
end

Fabricator(:other_money_record, from: :money_record) do
  adjusted_date DateTime.now
  amount "40.22"
end


Fabricator(:old_money_record, from: :money_record) do
  adjusted_date DateTime.now - 10.days
  amount "10.42"
end
