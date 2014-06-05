teams = Team.ordered
periods = Period.ordered
shifts = Shift.all

text = teams.map { |t|
  pp = periods.map { |p|
    ss = shifts.select { |sh|
      sh.participation.team_id == t.id && sh.period_id == p.id
    }.map { |sh|
      s = sh.participation.staff
      [s.grade, s.gender_to_s, s.full_name].join(' ')
    }.sort.join("\n")
    ["#{p.begins_at.strftime('%m/%d %H:%M')} ~ #{p.ends_at.strftime('%H:%M')}", ss].join("\n")
  }
  [t.name, pp].join("\n")
}.join("\n\n")

File.open('teams_shifts.txt', 'w') do |f|
  f.puts text
end
