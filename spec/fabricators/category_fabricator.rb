Fabricator :category do
  description "Some description"
  name "FooBarBaz"
  amount "20"
end

Fabricator(:archived_category, from: :category) do
  description "Archived Description"
  name "ArchivedName"
  amount "40"
  archived_at DateTime.now
end

Fabricator(:other_category, from: :category) do
  description "Other Description"
  name "OtherName"
  amount "60"
end


Fabricator(:cycle_category, from: :category) do
  description "Cycle Category"
  name "CycleCategory"
  amount "1000"
end

Fabricator(:paycheck_category, from: :category) do
  description "Paycheck description"
  name "PaycheckCategory"
  paycheck_percentage "20"
end
