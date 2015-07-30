(function() {
  'use strict';

  var UiComponentsSelect = React.createClass({
    propTypes: {
      remoteOptions: React.PropTypes.string,
      multiple: React.PropTypes.bool,
      options: React.PropTypes.arrayOf(
          React.PropTypes.oneOfType(React.PropTypes.string,
                                    React.PropTypes.arrayOf(React.PropTypes.string))),
      name: React.PropTypes.string,
      value: React.PropTypes.oneOfType([React.PropTypes.string,
                                           React.PropTypes.arrayOf(React.PropTypes.string)]),
      placeholder: React.PropTypes.string,
      className: React.PropTypes.string
    },

    getInitialState: function() {
      var options = this.normalizeOptions(this.props.options) || [];
      var selected = this.props.value ? _.flatten([this.props.value]) : [];
      var selectedOptions = _.filter(options, function(o) {
        return _.contains(selected, o.value)
      });

      return {
        options: options,
        value: selectedOptions
      };
    },

    render: function() {
      var props = _.extend({}, _.omit(this.props, 'name', 'multiple', 'className'), {
        options: this.state.options,
        asyncOptions: this.props.remoteOptions ? this.fetchOptions : null,
        onChange: this.handleChange,
        value: this.state.value,
        multi: this.props.multiple
      });

      if (!this.props.multiple || this.state.value.length === 0)
        props.name = this.props.name

      return React.createElement('div', { className: this.props.className },
		                         React.createElement(Select, props),
                                 this.renderValueMultiSelect());
    },

    renderValueMultiSelect: function() {
      if (!this.props.multiple)
        return null;

      var selectedOptions = _.map(this.state.value, function(v) {
        return React.createElement('option', { value: v.value, key: v.value, selected: true });
      });

      var props = {
        multiple: true,
        name: this.props.name,
        ref: 'valueSelect',
        value: _.pluck(this.state.value, 'value'), // TODO: Y U NO WORK?
        style: { display: 'none' }
      };

      return React.createElement('select', props, selectedOptions);
    },

    handleChange: function(newValue, newValues) {
      this.setState({ value: newValues });
    },

    componentDidUpdate: function(_prevProps, prevState) {
	  if (prevState.value !== this.state.value)
		if (this.props.multiple)
          $(this.getDOMNode()).find('select').trigger('change');
		else
          $(this.getDOMNode()).find('input[type="hidden"]').trigger('change');
    },

    fetchOptions: function(term, callback) {
      if (term.length < 3) {
        callback([]);
        return;
      }

      $.getJSON(this.props.remoteOptions + '?term=' + term, _.bind(function(data) {
        if (data.length === 0) return;
        callback(null, { options: this.normalizeOptions(data) });
      }, this));
    },

    normalizeOptions: function(options) {
      if (typeof(_.first(options)) === 'string')
        return _.map(options, function(o) {
          return { value: o, label: o};
        });
      else if (Array.isArray(_.first(options)))
        return _.map(options, function(o) {
          return { value: o[1], label: o[0] };
        });
      else
        return options;
    }
  });

  window.ui_components.Select = UiComponentsSelect;
})();
