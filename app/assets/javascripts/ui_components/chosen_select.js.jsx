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
    getInitialState: function() {
      return { value: this.strategy().initialValue, search: '' };
    },

    componentDidMount: function() {
      if (this.props.remote_options) {
        this.getChosenInput().on('keyup', _.bind(function(e) {
          this.state.search = $(e.target).val();
          var fetch = _.debounce(this.fetchOptions, 1000);
          if (this.state.search.length >= 3) fetch(this.state.search);
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
      return this.getChosen().find('input')
    },

    getChosen: function() {
      return $(this.refs.chosen.refs.select.getDOMNode()).siblings('.chosen-container');
    },

    fetchOptions: function() {
      $.getJSON(this.props.remote_options + '?term=' + this.state.search, _.bind(function(data) {
        var newOptions = data.map(function(el) { return [el.text, el.value]; })
        if (!newOptions.length) return;
        this.setState({ options: this.strategy().updateOptions(this.options(), newOptions) });
      }, this));
    },

    options: function () {
      return this.state.options || this.props.options || [];
    },

    renderLabel: function () {
      if (this.props.label)
        return <label htmlFor={this.props.name}>{this.props.label}</label>
    },
  
    renderOptions: function () {
      return this.options().map(function(pair) {
        return <option key={pair[1]} value={pair[1]}>{pair[0]}</option>
      })
    },

    classes: function () {
      var c = ['form-control'];
      if (this.props.inline)
        c.push('chosen-inline');
      if (this.props.classes)
        c.push(this.props.classes)
      return c.join(' ');
    },

    render: function() {
      return <div className="form-group">
               {this.renderLabel()}
               <Chosen id={this.props.name}
                       key={this.props.name}
                       name={this.props.name}
                       value={this.state.value}
                       allowSingleDeselect={true}
                       multiple={this.props.multiple}
                       ref="chosen"
                       data-placeholder={this.props.placeholder}
                       onChange={this.handleChange}
                       className={this.classes()}>
                 <option></option>
                 {this.renderOptions()}
               </Chosen>
             </div>;
    }
  });

  window.ui_components.Select = Select
})();
