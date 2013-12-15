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
      Section.create name: "section#{num}"
    end
  end

  desc 'setup all dummy data'
  task :setup => :environment do
    Rake::Task['dummy:staffs'].invoke
    Rake::Task['dummy:sections'].invoke
  end
end
