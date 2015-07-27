(function() {
  var TestUtils = {}

  var select = function(selectOption, options) {
    var $component = $(findComponentByLabel(options.from));
    var input = $component.find('.Select-input input').get()[0];

    trigger('focus', input);
    trigger('mouseDown', input);

    var option = _.find($component.find('.Select-option'), function(o) {
      return o.innerText.trim() === selectOption;
    });
    trigger('mouseDown', option);
    console.log('select');
  };
  
  var search = function(label, term) {
    var component = findComponentByLabel(label);
    var input = $(component).find('.Select-input input').get()[0];

    trigger('focus', input);
    trigger('change', input, { target: { value: term }});

    var option = _.find($(component).find('.Select-option'), function(o) {
      return o.innerText.indexOf(term) >= 0;
    });
    trigger('mouseDown', option);
    console.log('search');
  };

  var trigger = function(eventType, node, options) {
    React.addons.TestUtils.Simulate[eventType](node, options);
  };

  var findComponentByLabel = function(label) {
    var label = _.find($('label'), function(el) {
      return el.innerText.trim() === label;
    });
    return $(label).parent().find('[data-react-class]').get();
  };

  window.ui_components.TestUtils = {
    select: select,
    search: search,
  };
})();
