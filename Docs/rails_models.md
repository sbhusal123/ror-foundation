# Rails Models
- Models : `app/models/*`

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
- `after_initialize`

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
