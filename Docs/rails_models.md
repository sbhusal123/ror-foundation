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

## Generating Models, adding fields
- `rails g model <ModelName> <field>:<d_type> <field>:<d_type> <rel_name>:references`
- Mirate: `rake db:migrate` after migration schema file is updated.

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

**Setting Up DB relationship in Model Files**

- `models/project.rb`
```rb
class Project < ApplicationRecord
    has_many :tasks
  ......
end
```

**Generating Dummy Data from Rails Console:**

```rb
# get project id
irb(main):001:0> Project.last
   (0.4ms)  SELECT sqlite_version(*)
  Project Load (0.1ms)  SELECT "projects".* FROM "projects" ORDER BY "projects"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> #<Project id: 6, title: "Project 5", description: "This is project 5", percent_complete: 0.8e2, created_at: "2022-09-12 08:22:40.131160000 +0000", updated_at: "2022-09-13 09:37:12.703013000 +0000">

# create task
irb(main):002:0> Task.create!(title: "My first task", description: "asdlkj", project_id: 6)
  TRANSACTION (0.0ms)  begin transaction
  Project Load (0.1ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
  Task Create (0.2ms)  INSERT INTO "tasks" ("title", "description", "project_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["title", "My first task"], ["description", "asdlkj"], ["project_id", 6], ["created_at", "2022-09-13 10:24:57.089467"], ["updated_at", "2022-09-13 10:24:57.089467"]]
  TRANSACTION (2.4ms)  commit transaction
=> #<Task id: 1, title: "My first task", description: "asdlkj", project_id: 6, created_at: "2022-09-13 10:24:57.089467000 +0000", updated_at: "2022-09-13 10:24:57.089467000 +0000">

# check the records
irb(main):001:0> Project.last.tasks
   (0.2ms)  SELECT sqlite_version(*)
  Project Load (0.1ms)  SELECT "projects".* FROM "projects" ORDER BY "projects"."id" DESC LIMIT ?  [["LIMIT", 1]]
  Task Load (0.1ms)  SELECT "tasks".* FROM "tasks" WHERE "tasks"."project_id" = ? /* loading for inspect */ LIMIT ?  [["project_id", 6], ["LIMIT", 11]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Task id: 1, title: "My first task", description: "asdlkj", project_id: 6, created_at: "2022-09-13 10:24:57.089467000 +0000", updated_at: "2022-09-13 10:24:57.089467000 +0000">, #<Task id: 2, title: "My second task", description: "asdlkj", project_id: 6, created_at: "2022-09-13 10:26:29.282598000 +0000", updated_at: "2022-09-13 10:26:29.282598000 +0000">]>

irb(main):001:0> Task.first.project
   (0.2ms)  SELECT sqlite_version(*)
  Task Load (0.1ms)  SELECT "tasks".* FROM "tasks" ORDER BY "tasks"."id" ASC LIMIT ?  [["LIMIT", 1]]
  Project Load (0.1ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
=> #<Project id: 6, title: "Project 5", description: "This is project 5", percent_complete: 0.8e2, created_at: "2022-09-12 08:22:40.131160000 +0000", updated_at: "2022-09-13 09:37:12.703013000 +0000">
```


**Adding database fields:**
- ``rails g migration add_<field_name>_to_<model> <field>:<d_type>``
- ``rake db:migrate`` after migration: schema is changed: `t.boolean "completed"`
- Generated Migrations Files

```rb
class AddCompletedToTasks < ActiveRecord::Migration[6.1]
  def change
   # action    :model  :field      :type
    add_column :tasks, :completed, :boolean
  end
end
```


## Integrating callbacks, after_save

```rb
class Task < ApplicationRecord
  # Task.last.project
  belongs_to :project

  scope :completed, -> {where("completed=true")}

  # on save updates the percent completed for related project
  after_save :update_percent_completed if :mark_completed?

  def mark_completed?
    # Note: this doesnt doesnt perform scoped query call.
    self.completed == true
  end

  def update_percent_completed
      project = Project.find(self.project_id)
      count_of_completed_tasks = project.tasks.completed.count
      count_of_total_tasks = project.tasks.count
      project.update!(percent_complete: Counter.calculate_percent_complete(count_of_completed_tasks, count_of_total_tasks))
  end
end
```

**Testing on console**

```rb

# Note the percent complete
irb(main):001:0> Project.last
   (0.7ms)  SELECT sqlite_version(*)
  Project Load (0.1ms)  SELECT "projects".* FROM "projects" ORDER BY "projects"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> #<Project id: 6, title: "Project 5", description: "This is project 5", percent_complete: 0.0, created_at: "2022-09-12 08:22:40.131160000 +0000", updated_at: "2022-09-13 11:10:37.710385000 +0000">

# list of tasks for last project, notice the count
irb(main):002:0> Project.last.tasks
  Project Load (0.3ms)  SELECT "projects".* FROM "projects" ORDER BY "projects"."id" DESC LIMIT ?  [["LIMIT", 1]]
  Task Load (0.3ms)  SELECT "tasks".* FROM "tasks" WHERE "tasks"."project_id" = ? /* loading for inspect */ LIMIT ?  [["project_id", 6], ["LIMIT", 11]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Task id: 1, title: "My first task", description: "asdlkj", project_id: 6, created_at: "2022-09-13 10:24:57.089467000 +0000", updated_at: "2022-09-13 10:24:57.089467000 +0000", completed: nil>, #<Task id: 2, title: "My second task", description: "asdlkj", project_id: 6, created_at: "2022-09-13 10:26:29.282598000 +0000", updated_at: "2022-09-13 11:10:53.218693000 +0000", completed: false>]>

# notice the project_id
irb(main):003:0> Task.last
  Task Load (0.4ms)  SELECT "tasks".* FROM "tasks" ORDER BY "tasks"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> #<Task id: 2, title: "My second task", description: "asdlkj", project_id: 6, created_at: "2022-09-13 10:26:29.282598000 +0000", updated_at: "2022-09-13 11:10:53.218693000 +0000", completed: false>

# updating task as completed
irb(main):004:0> Task.last.update(completed: true)
  Task Load (0.3ms)  SELECT "tasks".* FROM "tasks" ORDER BY "tasks"."id" DESC LIMIT ?  [["LIMIT", 1]]
  TRANSACTION (0.1ms)  begin transaction
  Project Load (0.3ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
  Task Update (0.6ms)  UPDATE "tasks" SET "updated_at" = ?, "completed" = ? WHERE "tasks"."id" = ?  [["updated_at", "2022-09-13 11:11:48.761705"], ["completed", 1], ["id", 2]]
  Project Load (0.1ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
   (0.2ms)  SELECT COUNT(*) FROM "tasks" WHERE "tasks"."project_id" = ? AND (completed=true)  [["project_id", 6]]
   (0.2ms)  SELECT COUNT(*) FROM "tasks" WHERE "tasks"."project_id" = ?  [["project_id", 6]]
  Project Update (0.2ms)  UPDATE "projects" SET "percent_complete" = ?, "updated_at" = ? WHERE "projects"."id" = ?  [["percent_complete", 50.0], ["updated_at", "2022-09-13 11:11:48.771176"], ["id", 6]]
  TRANSACTION (24.2ms)  commit transaction
=> true

# finally, notice the percent completed
irb(main):005:0> Project.last
  Project Load (0.3ms)  SELECT "projects".* FROM "projects" ORDER BY "projects"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> #<Project id: 6, title: "Project 5", description: "This is project 5", percent_complete: 0.5e2, created_at: "2022-09-12 08:22:40.131160000 +0000", updated_at: "2022-09-13 11:11:48.771176000 +0000">


# marking task as incomplete
irb(main):006:0> Task.last.update(completed: false)
  Task Load (0.3ms)  SELECT "tasks".* FROM "tasks" ORDER BY "tasks"."id" DESC LIMIT ?  [["LIMIT", 1]]
  TRANSACTION (0.1ms)  begin transaction
  Project Load (0.2ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
  Task Update (0.5ms)  UPDATE "tasks" SET "updated_at" = ?, "completed" = ? WHERE "tasks"."id" = ?  [["updated_at", "2022-09-13 11:15:17.992722"], ["completed", 0], ["id", 2]]
  Project Load (0.2ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
   (0.2ms)  SELECT COUNT(*) FROM "tasks" WHERE "tasks"."project_id" = ? AND (completed=true)  [["project_id", 6]]
   (0.2ms)  SELECT COUNT(*) FROM "tasks" WHERE "tasks"."project_id" = ?  [["project_id", 6]]
  Project Update (0.3ms)  UPDATE "projects" SET "percent_complete" = ?, "updated_at" = ? WHERE "projects"."id" = ?  [["percent_complete", 0.0], ["updated_at", "2022-09-13 11:15:18.000379"], ["id", 6]]
  TRANSACTION (5.9ms)  commit transaction
=> true

# notice the percent complete
irb(main):007:0> Project.last
  Project Load (0.2ms)  SELECT "projects".* FROM "projects" ORDER BY "projects"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> #<Project id: 6, title: "Project 5", description: "This is project 5", percent_complete: 0.0, created_at: "2022-09-12 08:22:40.131160000 +0000", updated_at: "2022-09-13 11:15:18.000379000 +0000">
```

## Changing Data Type of Column
- `rails g migrate change_data_type_for_<field_name>`
- Modify the generated migration file.

```rb
class ChangeDataTypeForStage < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :stage, :string
  end
end

```
- rake db:migrate

## Delete Column For DB Tables
- `rails g migrate remove_<field>_from_<table> <field>:<type>`

**Scaffold Code**

```rb
class MigrationName < ActiveRecord:Migration

  def change
    remove_column :<table>, :<field>, :<type>
  end

end
```
