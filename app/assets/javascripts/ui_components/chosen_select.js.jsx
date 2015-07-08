(function () {
  var strategies = {
    single: {
      initialValue: '',

      updateValue: function(current, update) {
        return update ? update.selected : null;
      },

      updateOptions: function(existingOptions, newOptions) {
        return newOptions;
      }
    },

    multiple: {
      initialValue: [],

      updateValue: function(current, update) {
        if (update.selected) {
          return current.concat(update.selected);
        } else if (update.deselected) {
          return _.without(current, update.deselected);
        }
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

    getInitialState: function() {
      return { value: this.strategy().initialValue, search: '' };
    },

    componentDidMount: function() {
      if (this.props.remote_options) {
        this.getChosenInput().on('keyup', _.bind(function(e) {
          this.state.search = $(e.target).val();
          if (this.state.search.length >= 3) this.fetchOptions(this.state.search);
        }, this));
      }
    },

    strategy: function() {
      return this.props.multiple ? strategies.multiple : strategies.single;
    },

    componentDidUpdate: function() {
      this.getChosenInput().val(this.state.search);
    },

    handleChange: function (event, update) {
      this.setState({ value: this.strategy().updateValue(this.state.value, update) });
      this.getChosenInput().val('');
    },

    getChosenInput: function() {
      return $(this.refs.chosen.getDOMNode()).find('input');
    },

    fetchOptions: function() {
      $.getJSON(this.props.remote_options + '?term=' + this.state.search, _.bind(function(data) {
        var newOptions = data.map(function(el) { return [el.text, el.value]; });
        if (!newOptions.length) return;
        this.setState({ options: this.strategy().updateOptions(this.options(), newOptions) });
      }, this));
    },

    options: function () {
      return this.state.options || this.props.options || [];
    },

    classes: function () {
      var c = ['form-control'];
      if (this.props.inline)
        c.push('chosen-inline');
      if (this.props.classes)
        c.push(this.props.classes);
      return c.join(' ');
    },

    renderLabel: function () {
      if (this.props.label)
        return <label htmlFor={this.props.name}>{this.props.label}</label>;
    },
  
    renderOptions: function () {
      return this.options().map(function(pair) {
        return <option key={pair[1]} value={pair[1]}>{pair[0]}</option>;
      });
    },

    renderChosen: function() {
      var options = _.extend({}, this.chosenDefaults, this.props.chosenOptions, {
        id: this.props.name,
        key: this.props.name,
        name: this.props.name,
        value: this.state.value,
        multiple: this.props.multiple,
        'data-placeholder': this.props.placeholder,
        ref: 'chosen',
        onChange: this.handleChange,
        className: this.classes()
      });

      return React.createElement(Chosen, options,
        React.createElement('option'), this.renderOptions()
      );
    },

    render: function() {
      return <div className="form-group">
               {this.renderLabel()}
               {this.renderChosen()}
             </div>;
    }
  });

  window.ui_components.Select = Select;
})();
