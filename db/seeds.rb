if Section.where(name: '休憩').count == 0
  Section.create name: '休憩',
                 display_order: 1
end

if Team.where(name: '休憩').count == 0
  Team.create section_id: Section.where(name: '休憩')[0].id,
              name: '休憩',
              display_order: 1
end

if MailingList.where(account_name: 'all').count == 0
  MailingList.create account_name: 'all'
end

team_recess = Team.where(name: '休憩').first
all = MailingList.where(account_name: 'all').first
unless team_recess.mailing_lists.map(&:account_name).include? 'all'
  team_recess.mailing_lists << all
end
