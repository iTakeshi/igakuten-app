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
                   email_verification_code: SecureRandom.hex(10),
                   email_verificated: num.to_i <= 5 ? false : true,
                   provisional: num.to_i <= 10 ? true : false
    end
  end
end
