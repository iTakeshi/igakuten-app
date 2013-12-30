json.array!(@teams) do |team|
  json.extract! team, :id, :section_id, :name
end
