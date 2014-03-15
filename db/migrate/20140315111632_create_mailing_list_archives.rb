class CreateMailingListArchives < ActiveRecord::Migration
  def change
    create_table :mailing_list_archives do |t|
      t.references :mailing_list, index: true
      t.references :staff, index: true
      t.string :subject
      t.text :body
      t.text :raw_source

      t.timestamps
    end
  end
end
