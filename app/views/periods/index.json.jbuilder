json.array!(@periods) do |period|
  json.extract! period, :id, :time
end
