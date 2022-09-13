# Rails Console
- Similar to django shell
- Testing out, inserting records, db querying
- Command: `rails c`
-  `rails c --sandbox` on sandbox mode, any modifications made will be rolled back on exit. (Caveats: Not to use for emails.)

## 1. Creating a records through console:

**i. Displaying a records**
- `<Model>.all` => display all the records
- `<Model>.count` => the count
- `<Model>.limit(<lim>)` => show first <lim> records
- `<Model>.last` => last entry.


**Project.all output**
``rb

irb(main):001:0> Project.all
   (1.0ms)  SELECT sqlite_version(*)
  Project Load (0.5ms)  SELECT "projects".* FROM "projects" /* loading for inspect */ LIMIT ?  [["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Project id: 2, title: "Test Project", description: "asd", percent_complete: nil, created_at: "2022-09-06 10:45:39.237406000 +0000", updated_at: "2022-09-06 10:45:39.237406000 +0000">, #<Project id: 3, title: "asd", description: "dadasd", percent_complete: nil, created_at: "2022-09-06 11:31:47.199783000 +0000", updated_at: "2022-09-06 11:31:47.199783000 +0000">, #<Project id: 4, title: "Project 0", description: "This is project 0 description.", percent_complete: nil, created_at: "2022-09-08 11:18:58.485010000 +0000", updated_at: "2022-09-08 11:18:58.485010000 +0000">, #<Project id: 5, title: "Project 1", description: "This is project 1 description.", percent_complete: nil, created_at: "2022-09-08 11:18:58.611470000 +0000", updated_at: "2022-09-08 11:18:58.611470000 +0000">]>
``


**ii. Creating a records in db**

```rb
# Create a basic looping statement and create 10 different entries
irb(main):001:0> 10.times do |project|

# ! here prevents silent exit on error
irb(main):002:1*   Project.create!(title: "Project #{project}", description: "This is project #{project} description.")
irb(main):003:1> end
```

**Output**
```rb
  (0.5ms)  SELECT sqlite_version(*)
  TRANSACTION (0.1ms)  begin transaction
  Project Create (15.7ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 0"], ["description", "This is project 0 description."], ["created_at", "2022-09-08 11:18:58.485010"], ["updated_at", "2022-09-08 11:18:58.485010"]]
  TRANSACTION (101.9ms)  commit transaction

  TRANSACTION (0.2ms)  begin transaction
  Project Create (1.7ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 1"], ["description", "This is project 1 description."], ["created_at", "2022-09-08 11:18:58.611470"], ["updated_at", "2022-09-08 11:18:58.611470"]]
  TRANSACTION (89.3ms)  commit transaction

  TRANSACTION (0.1ms)  begin transaction
  Project Create (2.4ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 2"], ["description", "This is project 2 description."], ["created_at", "2022-09-08 11:18:58.710100"], ["updated_at", "2022-09-08 11:18:58.710100"]]
  TRANSACTION (87.9ms)  commit transaction

  TRANSACTION (0.1ms)  begin transaction
  Project Create (1.8ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 3"], ["description", "This is project 3 description."], ["created_at", "2022-09-08 11:18:58.810342"], ["updated_at", "2022-09-08 11:18:58.810342"]]
  TRANSACTION (89.0ms)  commit transaction

  TRANSACTION (0.1ms)  begin transaction
  Project Create (2.4ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 4"], ["description", "This is project 4 description."], ["created_at", "2022-09-08 11:18:58.912039"], ["updated_at", "2022-09-08 11:18:58.912039"]]
  TRANSACTION (86.4ms)  commit transaction

  TRANSACTION (0.2ms)  begin transaction
  Project Create (5.0ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 5"], ["description", "This is project 5 description."], ["created_at", "2022-09-08 11:18:59.012500"], ["updated_at", "2022-09-08 11:18:59.012500"]]
  TRANSACTION (95.5ms)  commit transaction

  TRANSACTION (0.1ms)  begin transaction
  Project Create (0.4ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 6"], ["description", "This is project 6 description."], ["created_at", "2022-09-08 11:18:59.119085"], ["updated_at", "2022-09-08 11:18:59.119085"]]
  TRANSACTION (77.8ms)  commit transaction

  TRANSACTION (0.1ms)  begin transaction
  Project Create (0.4ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 7"], ["description", "This is project 7 description."], ["created_at", "2022-09-08 11:18:59.202191"], ["updated_at", "2022-09-08 11:18:59.202191"]]
  TRANSACTION (98.0ms)  commit transaction

  TRANSACTION (0.1ms)  begin transaction
  Project Create (0.4ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 8"], ["description", "This is project 8 description."], ["created_at", "2022-09-08 11:18:59.309005"], ["updated_at", "2022-09-08 11:18:59.309005"]]
  TRANSACTION (93.1ms)  commit transaction
  
  TRANSACTION (0.2ms)  begin transaction
  Project Create (2.2ms)  INSERT INTO "projects" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Project 9"], ["description", "This is project 9 description."], ["created_at", "2022-09-08 11:18:59.406687"], ["updated_at", "2022-09-08 11:18:59.406687"]]
  TRANSACTION (89.0ms)  commit transaction
```

**iii. Update**
- Select the last one for update => `p = Project.last`
- Update => `p.update!(title: "<New Val>")`
- Save => `p.save`

**Output**

```rb
irb(main):009:0> p = Project.last
  Project Load (0.3ms)  SELECT "projects".* FROM "projects" ORDER BY "projects"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> #<Project id: 5, title: "Updated Project Title", description: "This is project 1 description.", percent_complete: nil, created_at: "2022-09-08 11:18:58.611470000 +0000", updated_at: "2022-09-08 11:34:02.388112000 +0000">

irb(main):010:0> p.update!(title: "last updated")
  TRANSACTION (0.3ms)  begin transaction
  Project Update (0.9ms)  UPDATE "projects" SET "title" = ?, "updated_at" = ? WHERE "projects"."id" = ?  [["title", "last updated"], ["updated_at", "2022-09-08 11:34:56.729142"], ["id", 5]]
  TRANSACTION (101.7ms)  commit transaction
```

**iv. Delete**
- `<container_var>.delete`

```rb
irb(main):013:0> p.delete
  Project Destroy (94.6ms)  DELETE FROM "projects" WHERE "projects"."id" = ?  [["id", 5]]
=> #<Project id: 5, title: "last updated", description: "This is project 1 description.", percent_complete: nil, created_at: "2022-09-08 11:18:58.611470000 +0000", updated_at: "2022-09-08 11:34:56.729142000 +0000">
```

**Find By Id (Multiple)**
- `<Model>.find([<id>, <id>])`
- Returns an array of items

```rb
irb(main):009:0> a = Project.find([1, 3, 5])
irb(main):009:0> a
  Project Load (0.6ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" IN (?, ?, ?)  [["id", 1], ["id", 3], ["id", 5]]
=> [#<Project id: 1, title: "Project 0", description: "This is project 0", percent_complete: nil, created_at: "2022-09-12 08:22:40.098896000 +0000", updated_at: "2022-09-12 08:22:40.098896000 +0000">, #<Project id: 3, title: "Project 2", description: "This is project 2", percent_complete: nil, created_at: "2022-09-12 08:22:40.119145000 +0000", updated_at: "2022-09-12 08:22:40.119145000 +0000">, #<Project id: 5, title: "Project 4", description: "This is project 4", percent_complete: nil, created_at: "2022-09-12 08:22:40.127831000 +0000", updated_at: "2022-09-12 08:22:40.127831000 +0000">]
irb(main):010:0> 
```

**Iterating through array of objects**
irb(main):016:0> a.each do |pro|
irb(main):017:1*  puts pro.description
irb(main):018:1> end
This is project 0
This is project 1
This is project 2
```
```

**Where Query**
- `<Model>.where(<field>: "<val>")`
- `<Model>.where.not(<field>: "<val>")`
- Returns an iteratable.

```rb
irb(main):001:0> p = Project.where(title: "Project 2")
   (0.3ms)  SELECT sqlite_version(*)
  Project Load (0.2ms)  SELECT "projects".* FROM "projects" WHERE "projects"."title" = ? /* loading for inspect */ LIMIT ?  [["title", "Project 2"], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Project id: 3, title: "Project 2", description: "This is project 2", percent_complete: nil, created_at: "2022-09-12 08:22:40.119145000 +0000", updated_at: "2022-09-12 08:22:40.119145000 +0000">]>

irb(main):002:0> p = Project.where.not(title: "Project 2")
  Project Load (0.9ms)  SELECT "projects".* FROM "projects" WHERE "projects"."title" != ? /* loading for inspect */ LIMIT ?  [["title", "Project 2"], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Project id: 1, title: "Project 0", description: "This is project 0", percent_complete: nil, created_at: "2022-09-12 08:22:40.098896000 +0000", updated_at: "2022-09-12 08:22:40.098896000 +0000">, #<Project id: 2, title: "Project 1", description: "This is project 1", percent_complete: nil, created_at: "2022-09-12 08:22:40.110935000 +0000", updated_at: "2022-09-12 08:22:40.110935000 +0000">, #<Project id: 4, title: "Project 3", description: "This is project 3", percent_complete: nil, created_at: "2022-09-12 08:22:40.123889000 +0000", updated_at: "2022-09-12 08:22:40.123889000 +0000">, #<Project id: 5, title: "Project 4", description: "This is project 4", percent_complete: nil, created_at: "2022-09-12 08:22:40.127831000 +0000", updated_at: "2022-09-12 08:22:40.127831000 +0000">, #<Project id: 6, title: "Project 5", description: "This is project 5", percent_complete: nil, created_at: "2022-09-12 08:22:40.131160000 +0000", updated_at: "2022-09-12 08:22:40.131160000 +0000">]>

# p.first.title
```

- **Chaining**: `Project.where.not(title: "This is project 1").limit(10)`


```sh
irb(main):001:0> Project.where.not(title: "This is project 1").limit(10)

   (0.4ms)  SELECT sqlite_version(*)
  Project Load (0.2ms)  SELECT "projects".* FROM "projects" WHERE "projects"."title" != ? /* loading for inspect */ LIMIT ?  [["title", "This is project 1"], ["LIMIT", 10]]
=> #<ActiveRecord::Relation [#<Project id: 1, title: "Project 0", description: "This is project 0", percent_complete: 0.2e2, created_at: "2022-09-12 08:22:40.098896000 +0000", updated_at: "2022-09-13 04:21:41.544245000 +0000">, #<Project id: 2, title: "Project 1", description: "This is project 1", percent_complete: nil, created_at: "2022-09-12 08:22:40.110935000 +0000", updated_at: "2022-09-12 08:22:40.110935000 +0000">, #<Project id: 3, title: "Project 2", description: "This is project 2", percent_complete: nil, created_at: "2022-09-12 08:22:40.119145000 +0000", updated_at: "2022-09-12 08:22:40.119145000 +0000">, #<Project id: 4, title: "Project 3", description: "This is project 3", percent_complete: nil, created_at: "2022-09-12 08:22:40.123889000 +0000", updated_at: "2022-09-12 08:22:40.123889000 +0000">, #<Project id: 5, title: "Project 4", description: "This is project 4", percent_complete: nil, created_at: "2022-09-12 08:22:40.127831000 +0000", updated_at: "2022-09-12 08:22:40.127831000 +0000">, #<Project id: 6, title: "Project 5", description: "This is project 5", percent_complete: nil, created_at: "2022-09-12 08:22:40.131160000 +0000", updated_at: "2022-09-12 08:22:40.131160000 +0000">]>
```