json.array!(@sections) do |section|
  json.extract! section, :id, :name
end
