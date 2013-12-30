if Section.where(name: '休憩').count == 0
  Section.create name: '休憩',
                 display_order: 1
end

if Team.where(name: '休憩').count == 0
  Team.create section_id: Section.where(name: '休憩')[0].id,
              name: '休憩',
              display_order: 1
end
