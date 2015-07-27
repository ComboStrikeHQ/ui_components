(function() {
  var UiComponentsSelect = React.createClass({
    propTypes: {
      remoteOptions: React.PropTypes.string,
      multiple: React.PropTypes.bool,
      options: React.PropTypes.arrayOf(
          React.PropTypes.oneOfType(React.PropTypes.string,
                                    React.PropTypes.arrayOf(React.PropTypes.string))),
      name: React.PropTypes.string,
      selected: React.PropTypes.oneOfType([React.PropTypes.string,
                                           React.PropTypes.arrayOf(React.PropTypes.string)]),
      placeholder: React.PropTypes.string,
      className: React.PropTypes.string
    },

    getInitialState: function() {
      return {
        options: this.normalizeOptions(this.props.options) || []
      };
    },

    render: function() {
      var props = _.extend({}, this.props, {
        options: this.state.options,
        asyncOptions: this.props.remoteOptions ? this.fetchOptions : null
      });

      return React.createElement(Select, props);
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
