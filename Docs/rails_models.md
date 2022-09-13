# Rails Models
- Models : `app/models/*`
- Docs: [Here](https://guides.rubyonrails.org/active_record_basics.html)

## Purpose
- Custom Scopes
- Adding defaults
- Callbacks
- Database Relationships


## Custom Model Methods / Scopes
- Scopes are special methods to run SQL queries that you can build in any rails model.


**i. projects_controller.rb**
- 
```rb
class Project < ApplicationRecord
    scope :almost_completed, -> {where('percent_complete > 70.0')}
    scope: still_needs_some_work, -> {where('percent_complete < 70.0')}
end

# accessing scopes
Project.almost_completed
```

**ii. Defaults fields value**
- Custom `initializer`.
- `after_initialize :`

```rb
...
    # !! after_create wont work, wipes out the value
    after_initialize :set_defaults

    # on initialization check if percent_complete set else set it to 0.0
    def set_defaults
        self.percent_complete ||= 0.0
    end
...
```

## Validations

**i. Validate non empty, presence of fields:**
- `validates_presence_of :field1, :field2`

```rb
.....
        validates_presence_of :title, :description
.....
```

## Generating Models
- `rails g model <ModelName> <field>:<d_type> <field>:<d_type> <rel_name>:references`
- Mirate: `rake db:migrate`

**Example: Generating with references:**
```sh
rails g model Task title:string description:text project:references
```

**Output:**

```s
      invoke  active_record
      create    db/migrate/20220913101443_create_tasks.rb
      create    app/models/task.rb
      invoke    test_unit
      create      test/models/task_test.rb
      create      test/fixtures/tasks.yml
```

**MIgration File**

```rb
class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```

