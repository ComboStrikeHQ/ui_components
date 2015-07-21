(function () {
  var strategies = {
    single: {
      updateValue: function(current, update) {
        if (!update) return current;

        return update.selected ? [update.selected] : [];
      },

      updateOptions: function(_component, newOptions) {
        return newOptions;
      }
    },

    multiple: {
      updateValue: function(current, update) {
        if (!update) return current;

        if (update.selected)
          return current.concat(update.selected);
        else if (update.deselected)
          return _.without(current, update.deselected);
        else
          return current;
      },

      updateOptions: function(component, newOptions) {
        return _.union(component.selectedOptions(), newOptions);
      }
    }
  };

  var Select = React.createClass({
    chosenDefaults: {
      searchContains: true
    },

    propTypes: {
      remoteOptions: React.PropTypes.string,
      multiple: React.PropTypes.bool,
      options: React.PropTypes.arrayOf(
        React.PropTypes.oneOfType(React.PropTypes.string,
                                  React.PropTypes.arrayOf(React.PropTypes.string))),
      name: React.PropTypes.string,
      selected: React.PropTypes.oneOfType([
        React.PropTypes.string,
        React.PropTypes.arrayOf(React.PropTypes.string)
      ]),
      placeholder: React.PropTypes.string,
      className: React.PropTypes.string
    },

    getInitialState: function() {
      return {
        search: '',
        value: this.props.selected ? _.flatten([this.props.selected]) : [],
        options: this.props.options ? this.normalizeOptions(this.props.options) : []
      };
    },

    componentDidMount: function() {
      this.getChosenInput().on('keyup', _.bind(function(e) {
        if (e.key.match(/^Arrow/))
          return;
        var search = $(e.target).val() || '';
        this.setState({ search: search });
        if (this.props.remoteOptions && this.state.search.length >= 3)
          this.debouncedFetchOptions(this.state.search);
      }, this));
    },

    strategy: function() {
      return this.props.multiple ? strategies.multiple : strategies.single;
    },

    componentDidUpdate: function() {
      var input = this.getChosenInput();
      input.val(this.state.search);
      input.css({ width: '100%' });
    },

    handleChange: function(event, update) {
      var newState = {
        value: this.strategy().updateValue(this.state.value, update),
        search: ''
      };

      if (this.props.remoteOptions)
        newState.options = this.selectedOptions(newState.value);

      this.setState(newState);
    },

    selectedOptions: function(values) {
      var component = this;
      return _.filter(component.state.options, function(o) {
        return _.contains(values || component.state.value, _.last(o));
      });
    },

    getChosenInput: function() {
      return $(this.refs.chosen.getDOMNode()).find('input');
    },

    fetchOptions: function() {
      var component = this;

      $.getJSON(this.props.remoteOptions + '?term=' + this.state.search, function(data) {
        var newOptions = data.map(function(el) { return [el.text, el.value]; });
        if (!newOptions.length) return;
        component.setState({ options: component.strategy().updateOptions(component, newOptions) });
      });
    },

    debouncedFetchOptions: _.debounce(function() { this.fetchOptions() }, 250),

    normalizeOptions: function(options) {
      if (typeof(options) == 'array' && typeof(_.first(options)) == 'string')
        return _.map(options, function(option) { [option, option] });
      else
        return options;
    },

    id: function () {
      return this.props.id || this.props.name;
    },

    renderOptions: function () {
      return this.state.options.map(function(pair) {
        if (typeof pair === 'string') 
          pair = [pair, pair];
        return <option key={pair[1]} value={pair[1]}>{pair[0]}</option>;
      });
    },

    renderChosen: function() {
      var props = _.extend({}, this.chosenDefaults, _.pick(this.props, 'width', 'className'), {
        id: this.id(),
        key: this.props.name,
        name: this.props.name,
        value: this.props.multiple ? this.state.value : _.first(this.state.value),
        multiple: this.props.multiple,
        'data-placeholder': this.props.placeholder,
        ref: 'chosen',
        onChange: this.handleChange,
      });

      return React.createElement(Chosen, props,
        React.createElement('option'), this.renderOptions()
      );
    },

    render: function() {
      return this.renderChosen();
    }
  });

  window.ui_components.Select = Select;
})();
