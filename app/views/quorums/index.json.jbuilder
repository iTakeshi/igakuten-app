json.array!(@quorums) do |quorum|
  json.extract! quorum, :id, :period_id, :team_id, :quorum
end
