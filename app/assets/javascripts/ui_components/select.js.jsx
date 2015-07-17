(function () {
  var strategies = {
    single: {
      updateValue: function(current, update) {
        if (!update) return current;

        return update.selected ? [update.selected] : [];
      },

      updateOptions: function(existingOptions, newOptions) {
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

      updateOptions: function(existingOptions, newOptions) {
        return _.union(existingOptions, newOptions);
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
      var value = this.props.selected ? _.flatten([this.props.selected]) : [];
      return { value: value, search: '', options: [] };
    },

    componentDidMount: function() {
      if (this.props.remoteOptions) {
        this.getChosenInput().on('keyup', _.bind(function(e) {
          var search = $(e.target).val() || '';
          this.setState({ search: search });
          if (this.state.search.length >= 3) this.debouncedFetchOptions(this.state.search);
        }, this));
      }
    },

    strategy: function() {
      return this.props.multiple ? strategies.multiple : strategies.single;
    },

    componentDidUpdate: function() {
      this.getChosenInput().val(this.state.search);
    },

    handleChange: function(event, update) {
      this.setState({ value: this.strategy().updateValue(this.state.value, update) });
      this.getChosenInput().val('');
    },

    getChosenInput: function() {
      return $(this.refs.chosen.getDOMNode()).find('input');
    },

    fetchOptions: function() {
      var remoteOptions = this.props.remoteOptions || '';

      $.getJSON(remoteOptions + '?term=' + this.state.search, _.bind(function(data) {
        var newOptions = data.map(function(el) { return [el.text, el.value]; });
        if (!newOptions.length) return;
        this.setState({ options: this.strategy().updateOptions(this.options(), newOptions) });
      }, this));
    },

    debouncedFetchOptions: _.debounce(function() { this.fetchOptions() }, 250),

    options: function () {
      if (this.state.options.length > 0)
        return this.state.options;
      else if (this.props.options)
        return this.normalizeOptions(this.props.options);
      else
        return [];
    },

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
      return this.options().map(function(pair) {
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
