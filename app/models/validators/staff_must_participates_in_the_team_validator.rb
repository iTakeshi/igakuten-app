class StaffMustParticipatesInTheTeamValidator < ActiveModel::Validator
  def validate(record)
    unless record.staff.teams.exists?(record.team)
      record.errors.add :team_id, 'A staff can NOT work with a team he/she does not participates in.'
    end
  end
end
