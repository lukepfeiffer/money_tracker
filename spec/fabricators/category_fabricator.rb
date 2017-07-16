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
