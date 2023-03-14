class CreateTaskClearEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :task_clear_events do |t|
      # t.references :task, foreign_key: true
      t.bigint :task_id, :null => false
      t.references :cleared_task, foreign_key: true, :null => false
      t.datetime :event_datetime, :null => false
    end
  end
end
