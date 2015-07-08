//= require ui_components

describe('ui_components.Select', function() {
  var options = [['DE', 'de'], ['FR', 'fr'], ['ES', 'es']];
  var subject = React.addons.TestUtils.renderIntoDocument(
    React.createElement(ui_components.Select, { 
      options: options,
      inline: true,
      classes: 'my-custom-class',
      label: 'My label'
    })
  );

  it('renders the classes', function() {
    var $select = $(subject.getDOMNode()).find('select');
    expect($select.hasClass('form-control')).toBe(true);
    expect($select.hasClass('chosen-inline')).toBe(true);
    expect($select.hasClass('my-custom-class')).toBe(true);
  });

  it('renders the label', function() {
    var $label = $(subject.getDOMNode()).find('label');
    expect($label.text()).toEqual('My label');
  });

  describe('single', function() {
    var subject = React.addons.TestUtils.renderIntoDocument(
      React.createElement(ui_components.Select, { 
        multiple: false, options: options
      })
    );

    it('sets the initial state', function() {
      expect(subject.state.value).toEqual('');
      expect(subject.state.search).toEqual('');
    });

    it('renders the options', function() {
      var $node = $(subject.getDOMNode());
      expect($node.find('option').length).toEqual(4);
      expect($node.find('option').map(function() { return this.value }).get()).toEqual([
        '', 'de', 'fr', 'es'
      ]);
    });

    it('handles changes', function() {
      subject.refs.chosen.props.onChange({}, { selected: 'fr' });
      expect(subject.state.value).toEqual('fr');

      subject.refs.chosen.props.onChange({}, {});
      expect(subject.state.value).toBe(undefined);
    });
  });

  describe('multiple', function() {
    var subject = React.addons.TestUtils.renderIntoDocument(
      React.createElement(ui_components.Select, { 
        multiple: true, options: options,
      })
    );

    it('sets the initial state', function() {
      expect(subject.state.value).toEqual([]);
      expect(subject.state.search).toEqual('');
    });

    it('renders the options', function() {
      var $options = $(subject.getDOMNode()).find('option');
      expect($options.length).toEqual(4);
      expect($options.map(function() { return this.value }).get()).toEqual([
        '', 'de', 'fr', 'es'
      ]);
    });

    it('handles changes', function() {
      subject.refs.chosen.props.onChange({}, { selected: 'fr' });
      expect(subject.state.value).toEqual(['fr']);

      subject.refs.chosen.props.onChange({}, { selected: 'de' });
      expect(subject.state.value).toEqual(['fr', 'de']);

      subject.refs.chosen.props.onChange({}, { deselected: 'de' });
      expect(subject.state.value).toEqual(['fr']);
    });
  });

  describe('single with remote options', function() {
    var subject = React.addons.TestUtils.renderIntoDocument(
      React.createElement(ui_components.Select, { 
        multiple: false, remote_options: '/assets/fixtures/options.json'
      })
    );

    it('sets the initial state', function() {
      expect(subject.state.value).toEqual('');
      expect(subject.state.search).toEqual('');
    });

    it('loads the remote options when a search term is given', function() {
      spyOn($, 'getJSON').and.callFake(function(url, callback) {
        callback([
          { text: 'Australia', value: 'au'}, 
          { text: 'Austria', value: 'at'}
        ]);
      });

      triggerSearch(subject, 'Aus');
      expect(subject.state.options).toEqual([
        ['Australia', 'au'], ['Austria', 'at']
      ]);
    });
  });

  describe('multiple with remote options', function() {
    var subject = React.addons.TestUtils.renderIntoDocument(
      React.createElement(ui_components.Select, { 
        multiple: true, 
        options: [['Germany', 'de'], ['France', 'fr']],
        remote_options: '/assets/fixtures/options.json'
      })
    );

    it('sets the initial state', function() {
      expect(subject.state.value).toEqual([]);
      expect(subject.state.search).toEqual('');
    });

    it('loads the remote options when a search term is given', function() {
      spyOn($, 'getJSON').and.callFake(function(url, callback) {
        callback([
          { text: 'Australia', value: 'au'}, 
          { text: 'Austria', value: 'at'}
        ]);
      });

      triggerSearch(subject, 'Aus');
      expect(subject.options()).toEqual([
        ['Germany', 'de'], ['France', 'fr'],
        ['Australia', 'au'], ['Austria', 'at']
      ]);
    });
  });

  function triggerSearch(node, value) {
    $(node.refs.chosen.getDOMNode()).find('input')
      .val(value)
      .trigger('keyup');
  }
});
