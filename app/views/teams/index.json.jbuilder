json.array!(@teams) do |team|
  json.extract! team, :id, :section_id, :name
  json.url team_url(team, format: :json)
end
