staffs = Staff.ordered
periods = Period.ordered
shifts = Shift.all

text = Team.ordered.map { |t|
  staffs.map { |s|
    flag = (periods.map { |p|
      shsh = shifts.select { |sh|
        sh.participation.staff_id == s.id && sh.period_id == p.id && sh.participation.team_id != 1
      }
      if shsh.length == 1
        shsh.first.participation.team_id
      else
        nil
      end
    }.compact.first == t.id)

    pp = periods.map { |p|
      shsh = shifts.select { |sh|
        sh.participation.staff_id == s.id && sh.period_id == p.id && sh.participation.team_id != 1
      }
      if shsh.length == 1
        sh = shsh.first
        "#{p.begins_at.strftime('%m/%d %H:%M')} ~ #{p.ends_at.strftime('%H:%M')} #{sh.participation.team.name}"
      else
        nil
      end
    }.compact.join("\n")

    if flag
      [[s.grade, s.gender_to_s, s.full_name, s.email].join(' '), pp].join("\n")
    else
      nil
    end
  }.compact.join("\n\n")
}.join("\n\n----\n\n")

File.open('staffs_shifts.txt', 'w') { |f| f.puts text }
