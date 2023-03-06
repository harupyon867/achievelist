class CreateTaskClearEvent < ActiveRecord::Migration[7.0]
  def change
    create_table :task_clear_events do |t|
      t.references :task, foreign_key: true
      t.references :cleared_task, foreign_key: true
      t.datetime :event_datetime
    end
  end
end
