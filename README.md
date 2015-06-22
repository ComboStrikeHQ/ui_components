# UiComponents [![Circle CI](https://circleci.com/gh/ad2games/ui_components.svg?style=svg)](https://circleci.com/gh/ad2games/ui_components)

This gem provides common UI components for all
[ad2games](http://www.ad2games.com/) projects.

## Usage

To include this gem in the next big ad2games thing, add it to the Gemfile:

```ruby
gem 'ui_components', git: 'https://github.com/ad2games/ui_components'
```

Require it in the application.js or wherever you want to use it:

```js
//= require ui_components
```

Use the helper method in the views:

```haml
= ui_component(:select, form: form, options: @options)
```
