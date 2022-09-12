# Ruby Embeded Scripting

## Accessing / Printing context vars passed
```rb
<strong><%= project.title %></strong>
```

## Blocks

```rb
<% @projects.each do |project| %>
    <p>
        <strong><%= project.title %></strong>
    </p>
<% end %>
```

> Notice `=` difference in between above two scripts.