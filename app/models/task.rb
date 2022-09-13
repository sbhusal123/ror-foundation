class Task < ApplicationRecord
  # Task.last.project
  belongs_to :project
end
