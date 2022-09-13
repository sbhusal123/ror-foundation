class Project < ApplicationRecord
    # Custom Scopes
    # Add defaults
    # Integrate validations
    # Integrate Callbacks -> Sort of like signals
    # Database Relationships

    # Project.first.task
    has_many :task

    validates_presence_of :title, :description, :percent_completes

    scope :almost_completed, -> { where('percent_complete > 70.0') }
    scope :still_needs_some_work, -> { where('percent_complete < 75.0') }

    # customizing save, custom initializer
    # !! after create wont work, wipes out the value
    after_initialize :set_defaults

    # on initialization check if percent_complete set else set it to 0.0
    def set_defaults
        self.percent_complete ||= 0.0
    end

end
