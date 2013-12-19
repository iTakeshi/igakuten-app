namespace :dummy do
  desc 'create dummy staffs'
  task :staffs => :environment do
    ('01'..'30').each do |num|
      Staff.create family_name: 'hoge',
                   family_name_yomi: 'hoge',
                   given_name: num,
                   given_name_yomi: num,
                   grade: num.to_i % 6 + 1,
                   gender: num.to_i % 2,
                   phone: "000-0000-00#{num}",
                   email: "#{num}@example.com",
                   provisional: num.to_i <= 10 ? true : false
    end
    Staff.where(given_name: '03'..'30').each do |staff|
      staff.email_verificated = true
      staff.save!
    end
  end

  desc 'create dummy sections'
  task :sections => :environment do
    (1..5).each do |num|
      Section.create name: "section#{num}",
                     display_order: (num - 3) % 5 + 1
    end
  end

  desc 'create dummy teams'
  task :teams => :environment do
    Section.all.each do |section|
      1.upto(Random.new(section.id * 5).rand(3) + 2) do |num|
        Team.create section_id: section.id,
                    name: "team#{section.id}#{num}",
                    display_order: num
      end
    end
  end

  desc 'create dummy festival_dates'
  task :festival_dates => :environment do
    FestivalDate.create day: 1,
                        date: '2014-06-07'
    FestivalDate.create day: 2,
                        date: '2014-06-08'
  end

  desc 'create dummy periods'
  task :periods => :environment do
    (10..16).each do |begins_at|
      Period.create festival_date_id: 1,
                     begins_at: "2014-06-07 #{begins_at}:00:00",
                     ends_at:   "2014-06-07 #{begins_at + 1}:00:00"
      Period.create festival_date_id: 2,
                     begins_at: "2014-06-08 #{begins_at}:00:00",
                     ends_at:   "2014-06-08 #{begins_at + 1}:00:00"
    end
  end

  desc 'create dummy quorums'
  task :quorums => :environment do
    Team.all.each do |team|
      baseline = Random.rand(4) + 1
      Period.all.each do |period|
        Quorum.create team: team,
                      period: period,
                      quorum: baseline + Random.rand(2)
      end
    end
  end

  task :setup => :environment do
    Rake::Task['dummy:staffs'].invoke
    Rake::Task['dummy:sections'].invoke
    Rake::Task['dummy:teams'].invoke
    Rake::Task['dummy:festival_dates'].invoke
    Rake::Task['dummy:periods'].invoke
    Rake::Task['dummy:quorums'].invoke
  end
end
