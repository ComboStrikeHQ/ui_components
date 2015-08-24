# UiComponents [![Circle CI](https://circleci.com/gh/ad2games/ui_components.svg?style=svg)](https://circleci.com/gh/ad2games/ui_components)

This gem provides common UI components for all
[ad2games](http://www.ad2games.com/) projects as well as related documentation.
To view the documentation run the dummy app within the spec directory and
point your browser to [localhost:3000/](http://localhost:3000/) or similar.

## Usage

To include this gem in the next big ad2games thing, add it to the Gemfile:

```ruby
gem 'ui_components', git: 'https://github.com/ad2games/ui_components.git'
```

Require it in the application.js or wherever you want to use it:

```js
//= require ui_components
```

Use the helper method in the views:

```haml
= ui_component(:select, form: form, options: @options)
```

## Creating a component

In order to create a component, you need to follow these 17 simple steps:

1. Create a directory (`my_component`) with the component's intended name
   within the `app/cells` directory.
2. Within `app/cells/my_component`, create a class using the component's
   name with the suffix `Cell` (filename: `my_component_cell.rb`, classname:
   `MyComponentCell`).
3. Options to be passed to the `ui_component` helper for the component,
   need to be specified as 'attributes' in the class. For example:

   ```ruby
   class MyComponentCell
     attribute :my_attribute, description: 'A description of what the attribute is for.'
   end
   ```

   The `description` param is mandatory. A `mandatory: true` param can be
   added to flag the attribute as such.
3. Within `app/cells/my_component`, create a YAML file using the component's
   name (`my_component.yml`).
4. `my_component.yml` should contain a `description` text and a list
   of examples (at least one) under the `examples` key.
5. If all went well, you should see your component in the styleguide
   now.
6. Component specific Styles and Javascript should be added within
   `app/cells/my_component` as
   `my_component.scss` and `my_component.coffee` files respectively.
