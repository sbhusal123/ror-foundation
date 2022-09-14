class Task < ApplicationRecord
  # Task.last.project
  belongs_to :project

  scope :completed, -> {where("completed=true")}

  # uploader
  # mount uploader: field  ,   handler
  mount_uploader :task_file, TaskFileUploader

  after_save :update_percent_complete if :mark_completed?

  def mark_completed?
    # Note: this doesnt doesnt perform scoped query call.
    self.completed == true
  end

  def update_percent_complete
      project = Project.find(self.project_id)
      count_of_completed_tasks = project.tasks.completed.count
      count_of_total_tasks = project.tasks.count
      project.update!(percent_complete: Counter.calculate_percent_complete(count_of_completed_tasks, count_of_total_tasks))
  end
end
