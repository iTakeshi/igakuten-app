Team.all.each do |t|
  puts t.name
  t.staffs.ordered.each do |s|
    next if s.grade == 6
    puts "#{[
      s.grade,
      s.gender_to_s,
      s.family_name,
      s.given_name,
      s.family_name_yomi,
      s.given_name_yomi,
      s.email,
      s.phone =~ /\A000/ ? '' : s.phone,
      s.teams.map(&:name).select{|tn| tn != Team.find(1).name && tn != t.name}.join(',')
    ].join(',')}"
  end
  3.times { puts }
end

