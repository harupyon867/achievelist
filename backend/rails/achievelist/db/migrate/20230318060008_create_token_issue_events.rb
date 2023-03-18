class CreateTokenIssueEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :token_issue_events do |t|
      t.references :user, foreign_key: true, null: false
      t.text :refresh_token, null: false
      t.datetime :event_datetime, null: false
    end
  end
end
