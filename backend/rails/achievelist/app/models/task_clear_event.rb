class TaskClearEvent < ApplicationRecord
  require 'date'

  def self.task_clear(task_id, user_id)
    task = Task.find_by(id: task_id, user_id:)
    return false if task.nil?

    task_attr = task.attributes
    task_attr.delete('id')

    cleared_task = ClearedTask.new(task_attr)
    return false unless cleared_task.valid?

    event = nil

    transaction do
      cleared_task.save!
      task.destroy!

      event = new(
        {
          task_id: task.id,
          cleared_task_id: cleared_task.id,
          event_datetime: Time.current
        }
      )
      event.save!
    end

    !event.nil? && event.present?
  end
end
