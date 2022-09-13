# Ruby Embeded Scripting
- ERB templating syntax.

## Using external links
```rb
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

## Using Partials:
- Filename starting with `_` => partials

Including partials, rendering on view

```rb
<%= render "shared/nav" %>
```

- File location: `views/shared/_nav.html.erb`


## Inspecting Data Context Passed on views:

```rb
<%= <context_var>.inspect %>
```

## Conditional / Checks and String Interpolation

```rb
<em> <%= "#{foo.bar}" if foo.bar != nil %> </em>
<em> <%= "#{foo.bar}" unless !foo.bar  %> </em>
```
