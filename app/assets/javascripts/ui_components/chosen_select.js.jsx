(function () {
  window.Select = React.createClass({
    getInitialState: function() {
      return { value: '' };
    },

    handleChange: function (event, update) {
      this.setState({ value: update.selected });
    },

    options: function () {
      return this.props.options || [];
    },

    renderLabel: function () {
      if (this.props.label)
        return <label htmlFor={this.props.name}>{this.props.label}</label>
      else
        return '';
    },
  
    renderOptions: function () {
      return this.options().map(function(pair) {
        return <option key={pair[1]} value={pair[1]}>{pair[0]}</option>
      })
    },

    classes: function () {
      c = ['form-control'];
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
                       data-placeholder={this.props.placeholder}
                       onChange={this.handleChange}
                       className={this.classes()}>
                 <option></option>
                 { this.renderOptions() }
               </Chosen>
             </div>;
    }
  });

  //window.ui_components.Select = Select
})();
