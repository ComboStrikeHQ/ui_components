class Select extends React.Component {
  constructor(props) {
    super(props);
    this.state = { value: this.strategy().initialValue(this.props.selected), search: '' };
    this.debouncedFetchOptions = _.debounce(this.fetchOptions, 250);
  }

  componentDidMount() {
    if (this.props.remote_options) {
      this.getChosenInput().on('keyup', e => {
        this.state.search = $(e.target).val();
        if (this.state.search.length >= 3) this.debouncedFetchOptions(this.state.search);
      });
    }
  }

  strategy() {
    return this.props.multiple ? Select.strategies.multiple : Select.strategies.single;
  }

  componentDidUpdate() {
    this.getChosenInput().val(this.state.search);
  }

  handleChange(event, update) {
    this.setState({ value: this.strategy().updateValue(this.state.value, update) });
    this.getChosenInput().val('');
  }

  getChosenInput() {
    return $(React.findDOMNode(this.refs.chosen)).find('input');
  }

  fetchOptions() {
    $.getJSON(this.props.remote_options + '?term=' + this.state.search, data => {
      var newOptions = data.map(el => [el.text, el.value]);
      if (!newOptions.length) return;
      this.setState({ options: this.strategy().updateOptions(this.options(), newOptions) });
    });
  }

  options() {
    return this.state.options || this.props.options || [];
  }

  classes() {
    var c = ['form-control'];
    if (this.props.inline)
      c.push('chosen-inline');
    if (this.props.classes)
      c.push(this.props.classes);
    return c.join(' ');
  }

  id() {
    return this.props.id || this.props.name;
  }

  renderOptions() {
    return this.options().map(pair => {
      if (typeof pair === 'string') 
        pair = [pair, pair];
      return <option key={pair[1]} value={pair[1]}>{pair[0]}</option>;
    });
  }

  renderChosen() {
    var options = _.extend({}, this.chosenDefaults, this.props.chosenOptions, {
      id: this.id(),
      key: this.props.name,
      name: this.props.name,
      value: this.state.value,
      multiple: this.props.multiple,
      'data-placeholder': this.props.placeholder,
      ref: 'chosen',
      onChange: this.handleChange.bind(this),
      className: this.classes()
    });

    return React.createElement(Chosen, options, 
      React.createElement('option'), this.renderOptions()
    );
  }

  render() {
    return this.renderChosen();
  }
}

Select.propTypes = {
  remote_options: React.PropTypes.string,
  multiple: React.PropTypes.bool,
  options: React.PropTypes.any,
  name: React.PropTypes.string,
  selected: React.PropTypes.oneOfType([
    React.PropTypes.string,
    React.PropTypes.arrayOf(React.PropTypes.string)
  ]),
  placeholder: React.PropTypes.string,
  classes: React.PropTypes.string
};

Select.chosenDefaults = {
  searchContains: true
};

Select.strategies = {
  single: {
    initialValue: selected => selected || '',

    updateValue: (current, update) => update ? update.selected : null,

    updateOptions: (existingOptions, newOptions) => newOptions
  },

  multiple: {
    initialValue: selected => selected ? _.flatten([selected]) : [],

    updateValue: (current, update) => {
      if (update.selected) {
        return current.concat(update.selected);
      } else if (update.deselected) {
        return _.without(current, update.deselected);
      }
    }

    updateOptions: (existingOptions, newOptions) => (
      _.union(existingOptions, newOptions);
    )
  }
};

window.ui_components.Select = Select;
