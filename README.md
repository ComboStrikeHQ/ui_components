# UiComponents [![Circle CI](https://circleci.com/gh/ad2games/ui_components.svg?style=svg)](https://circleci.com/gh/ad2games/ui_components)

This gem provides common UI components for all
[ad2games](http://www.ad2games.com/) projects as well as related documentation.
To view the documentation run `rake styleguide` and point your browser to
[localhost:3999/](http://localhost:3999/). To specify a different port
run `rake styleguide[1234]` instead.

## Usage

To include this gem in the next big ad2games thing, add it to the Gemfile:

### Ruby

```ruby
gem 'ad2games-ui_components'
```
### Javascript

Require it in the application.js or wherever you want to use it:

```js
//= require ui_components
```
### Styles

Import the styles in the application.css. First the Bootstrap 'variables' file for
the project (to define colours etc.), then the a2g_ui_components.

a2g_ui_components includes ad2games' bootstrap override styles, related to the navbar, buttons,
form controls, toolbars, tables, etc.

```css
@import 'variables';
@import 'a2g_ui_components';
```

Alternatively, instead import just the unthemed (default Bootstrap) styles in the application.css.

```css
@import 'ui_components';
```

### Helpers

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

## Development

The bower assets are not included in the repository. Instead they are
packaged in to the gem when `rake release` is being run. For
development this means you need to call `rake bower:purge
bower:install:development` manually.

## TODO

* Move requiring of dependencies into individual components' JS and add
  tests (take a look at the modal component to see how).
* When updating to SASS 4, CSS should also be moved into the components'
  directories.
* Add types to attribute definitions in cells.
* Get rid of `UiComponents::FormHelper`.
