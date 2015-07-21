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

    normalizeOptions: function(options) {
      if (typeof(options) == 'array' && typeof(_.first(options)) == 'string')
        return _.map(options, function(option) { [option, option] });
      else
        return options;
    },

    componentDidMount: function() {
      this.getChosenInput().onkeyup = _.bind(function(e) {
        var searchTerm = e.target.value;

        this.updateSearch(searchTerm);

        if (searchTerm.length === 0)
          this.setState({ options: this.selectedOptions() });
        else if (this.props.remoteOptions && searchTerm.length === 3 && e.keyCode != 8)
          this.debouncedFetchOptions(searchTerm);
      }, this);
    },

    updateSearch: _.throttle(function(term) {
      this.setState({ search: term });
    }, 0),

    debouncedFetchOptions: _.debounce(function(term) { this.fetchOptions(term) }, 250),

    shouldComponentUpdate: function(nextProps, nextState) {
      if (nextState.options === this.state.options)
        return false;
      else
        return true;
    },

    componentDidUpdate: function() {
      var input = this.getChosenInput();
      input.value = this.state.search;
      input.style.width = '100%';
    },

    selectedOptions: function(values) {
      return _.filter(this.state.options, _.bind(function(o) {
        return _.contains(values || this.state.value, _.last(o));
      }, this));
    },

    getChosenInput: function() {
      if (this.refs.chosen)
        return this.refs.chosen.getDOMNode().getElementsByTagName('input')[0];
      else
        null;
    },

    fetchOptions: function(term) {
      $.getJSON(this.props.remoteOptions + '?term=' + term, _.bind(function(data) {
        var newOptions = data.map(function(el) { return [el.text, el.value]; });
        if (!newOptions.length) return;
        this.setState({ options: this.strategy().updateOptions(this, newOptions) });
      }, this));
    },

    strategy: function() {
      return this.props.multiple ? strategies.multiple : strategies.single;
    },

    render: function() {
      var options = this.renderOptions();
      var props = _.extend({}, this.chosenDefaults, _.pick(this.props, 'width', 'className'), {
        id: this.id(),
        key: this.props.name,
        name: this.props.name,
        multiple: this.props.multiple,
        'data-placeholder': this.props.placeholder,
        ref: 'chosen',
        onChange: this.handleChange,
        value: this.props.multiple ? this.state.value : _.first(this.state.value)
      });

      return React.createElement(Chosen, props, React.createElement('option'), options);
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

    handleChange: function(event, update) {
      this.setState({ value: this.strategy().updateValue(this.state.value, update), search: '' });
    }
  });

  window.ui_components.Select = Select;
})();
