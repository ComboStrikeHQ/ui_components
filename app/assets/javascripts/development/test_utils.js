(function() {
  var TestUtils = {}

  var select = function(selectOption, options) {
    var component = findComponent(options);
    if (!component)
      throw 'Component not found, options where ' + $.serialize(options);

    var $component = $(component);
    var input = $component.find('.Select-input input').get()[0];

    trigger('focus', input);
    trigger('mouseDown', input);

    var option = _.find($component.find('.Select-option'), function(o) {
      return o.innerText.trim().indexOf(selectOption) >= 0;
    });
    trigger('mouseDown', option);

    if (componentProps(component).multiple)
      trigger('mouseDown', $component.find('.Select-arrow').get()[0]);
  };
  
  var search = function(label, term) {
    var $component = $(findComponent({ from: label }));
    var input = $component.find('.Select-input input').get()[0];

    trigger('focus', input);
    trigger('change', input, { target: { value: term }});

    var option = _.find($component.find('.Select-option'), function(o) {
      return o.innerText.indexOf(term) >= 0;
    });
    trigger('mouseDown', option);
  };

  var trigger = function(eventType, node, options) {
    React.addons.TestUtils.Simulate[eventType](node, options);
  };

  var findComponent = function(options) {
    if (options.from)
      return findComponentByLabel(options.from);
    else if (options.fromName)
      return findComponentByName(options.fromName);
    else
      throw('No `from` or `fromName` option given');
  };

  var findComponentByLabel = function(label) {
    var label = _.find($('label'), function(el) {
      return el.innerText.trim() === label;
    });
    return $(label).parent().find('[data-react-class]').get();
  };

  var findComponentByName = function(name) {
    return $('[name="' + name + '"]').closest('[data-react-class]').get();
  };

  var componentProps = function(component) {
    return JSON.parse($(component).attr('data-react-props'));
  };

  window.ui_components.TestUtils = {
    select: select,
    search: search,
    trigger: trigger,
  };
})();
