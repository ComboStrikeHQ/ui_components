# UiComponents [![Circle CI](https://circleci.com/gh/ad2games/ui_components.svg?style=svg)](https://circleci.com/gh/ad2games/ui_components)

This gem provides common UI components for all
[ad2games](http://www.ad2games.com/) projects as well as related documentation.
To view the documentation run `rake styleguide` and point your browser to
[localhost:3999/](http://localhost:3999/). To specify a different port
run `rake styleguide[1234]` instead.

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

```slim
= ui_component(:select, form: form, options: @options)
```

## Creating a Component

In order to create a new component, come up with a great name and feed
it to the generator:

```
thor generate_component GREAT_NAME
```

### A Component's Components Explained

A component consists of a bunch of files in a single directory in
`app/cells`:

* `app/cells/my_component/my_component_cell.rb` <br/>
  This is the core of a component. An attribute has to be defined for each
  param the component should accept:

   ```ruby
   class MyComponentCell
     attribute :my_attribute, description: 'A description of what the attribute is for.'
   end
   ```

   The `description` param is mandatory. A `mandatory: true` param can be
   added to flag the attribute as such.

* `app/cells/my_component/my_component.slim` <br/>
  In the view, attributes and methods of the cell class can be accessed
  by just calling them in the view's scope. E.g., given the cell class
  has a method or an attribute `name`:

  ```slim
  h1= "Hello, {name}!"
  ```

* `app/cells/my_component/my_component.yml` <br/>
  A description of the component as well at least one example have to be
  provided here. Examples can consist of either a bunch of attributes or
  a string with example Slim markup:

  ```yaml
  description: 'My super cool component.'
  examples:
    - attributes:
        name: 'Max Mustermann'
        favorite_color: 'yellow'
    - slim: |
        = ui_component 'my_component', name: 'Max Mustermann',
                                       favorite_color: 'yellow'
  ```

* `app/cells/my_component/my_component.coffee` <br/>
  All JavaScript related to the component goes here.

* `app/cells/my_component/my_component.scss` <br/>
  All CSS related to the component goes here.

## TODO

* Move requiring of dependencies into individual components' JS and add
  tests.
* Add types to attribute definitions in cells.
* Get rid of `UiComponents::FormHelper`.
