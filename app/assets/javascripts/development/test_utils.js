(function() {
  var TestUtils = {}

  var select = function(selectedOption, options) {
    var component = findComponent(options);
    var $component = $(component);
    var input = $component.find('.Select-input input').get()[0];

    trigger('focus', input);
    trigger('mouseDown', input);
    trigger('change', input, { target: { value: selectedOption }})

    var waitForOptions = function(i) {
      if ($component.find('.Select-menu').text().indexOf(selectedOption) >= 0 || i <= 0)
        selectOption(selectedOption, $component);
      else {
        _.delay(waitForOptions, 100, i - 1);
      }
    };
    waitForOptions(20);
  };

  var selectOption = function(selectedOption, $component) {
    var options = $component.find('.Select-option');
    var option = _.find(options, function(o) {
      return o.innerText.trim().indexOf(selectedOption) >= 0;
    });
    if (!option)
      throw 'Option "' + selectedOption + '" not found in [' + _.pluck(options, 'innerText') + ']';
    trigger('mouseDown', option);

    if (componentProps($component[0]).multiple)
      trigger('mouseDown', $component.find('.Select-arrow').get()[0]);
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
    trigger: trigger,
  };
})();
