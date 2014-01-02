json.array!(@participations) do |participation|
  json.extract! participation, :id, :team_id, :staff_id
end
