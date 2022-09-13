# Static and Assets
- Images
- CSS
- Configs

## Loading Images on View:
- Docs: [Here](https://apidock.com/rails/ActionView/Helpers/AssetTagHelper/image_tag)

```erb
<%= image_tag("logos/logo.png", width: "...px", ...) %>
```

> `logo.png` must exist at `app/assets/images/logo`.

## Styles Referencing:

**How is style files autoloaded in views?**

```
app
├── assets
│   ├── config
│   │   └── manifest.js
│   ├── images
│   │   └── logos
│   │       └── logo.png
│   └── stylesheets
│       ├── application.css
│       ├── pages.scss
│       ├── projects.scss
│       └── scaffolds.scss
└── views
    ├── layouts
    │   ├── application.html.erb
    │   ├── mailer.html.erb
    │   └── mailer.text.erb
    ├── pages
    │   ├── about.html.erb
    │   ├── contact.html.erb
    │   ├── error.html.erb
    │   └── home.html.erb
    | ......

```

- Styling from `app/assets/stylesheets/application.css` applied to entire views.
- Styling from `app/assets/stylesheets/pages.scss` appied to all views inside `views/pages/*` (pages controller).

Note: **Any Styles files created on ``app/assets/stylesheets`` will be applied to `application.css`** because of `*= require_tree .`

## Integrating Fonts, Configuration
- Configuring fonts to be integrated.
- Fonts directory: `app/assets/fonts`

**config/application.rb**
```rb
config.assets.enabled = true
config.assets.paths << Ruby.root.join("/app/assets/fonts")
```

> Fonts placed inside ``/app/assets/fonts/*``

