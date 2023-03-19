class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.datetime :limit, null: false
      t.string :priority, null: false
    end
  end
end
