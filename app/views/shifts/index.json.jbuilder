json.array!(@shifts) do |shift|
  json.extract! shift, :id, :period_id, :team_id, :staff_id
end
