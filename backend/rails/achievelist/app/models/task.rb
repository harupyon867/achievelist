class Task < ApplicationRecord
  validates :name, length: { minimum: 1, maximum: 200 }
  validates :priority, inclusion: {
    in: %w[HIGH MIDDLE LOW)],
    message: '優先度は (HIGH MIDDLE LOW) から選択して下さい。'
  }
  validates :limit, datetime: {
    message: '正式な日時を入力してください。'
  }
end
