class CreateMailingListsTeams < ActiveRecord::Migration
  def change
    create_table :mailing_lists_teams, id: false do |t|
      t.integer :mailing_list_id
      t.integer :team_id
    end

    add_index :mailing_lists_teams, [:mailing_list_id, :team_id], unique: true
  end
end
