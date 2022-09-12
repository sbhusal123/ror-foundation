# Ruby Embeded Scripting

## Using external links
```erb
<%= link_to "Display Text", <rotes>_path %>
<%= link_to "Home", root_path %>
<%= link_to "Blog", bloog_path %>
```

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