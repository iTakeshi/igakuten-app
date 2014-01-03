json.array!(@shifts) do |shift|
  json.extract! shift, :id, :participation_id, :period_id
end
