//= require ui_components

describe('ui_components.Select', function() {
  var options = [['DE', 'de'], ['FR', 'fr'], ['ES', 'es']];
  var subject = React.addons.TestUtils.renderIntoDocument(
    React.createElement(ui_components.Select, { 
      options: options,
      inline: true,
      className: 'my-custom-class',
      id: 'my-custom-id'
    })
  );
  var $subject = $(subject.getDOMNode());
  var $search = $subject.find('input');

  it('renders the classes', function() {
    var $select = $subject.find('select');
    expect($select.hasClass('my-custom-class')).toBe(true);
  });

  it('renders the id', function() {
    var $select = $subject.find('select');
    expect($select.is('#my-custom-id')).toBe(true);
  });

  it('keeps the search state up-to-date', function() {
    expect($search.val()).toEqual('');
    triggerSearch(subject, 'foo')
    expect($search.val()).toEqual('foo');
    expect(subject.state.search).toEqual('foo');
  });

  describe('single', function() {
    var subject = React.addons.TestUtils.renderIntoDocument(
      React.createElement(ui_components.Select, { 
        multiple: false, options: options
      })
    );

    it('sets the initial state', function() {
      expect(subject.state.value).toEqual([]);
      expect(subject.state.search).toEqual('');
    });

    it('renders the options', function() {
      var $node = $subject;
      expect($node.find('option').length).toEqual(4);
      expect($node.find('option').map(function() { return this.value }).get()).toEqual([
        '', 'de', 'fr', 'es'
      ]);
    });

    it('handles changes', function() {
      subject.refs.chosen.props.onChange({}, { selected: 'fr' });
      expect(subject.state.value).toEqual(['fr']);

      subject.refs.chosen.props.onChange({}, {});
      expect(subject.state.value).toEqual([]);
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
      var $options = $subject.find('option');
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
        multiple: false, remoteOptions: '/assets/fixtures/options.json'
      })
    );

    beforeEach(function() {
      spyOn(subject, 'debouncedFetchOptions').and.callFake(subject.fetchOptions);
    });

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
        remoteOptions: '/assets/fixtures/options.json'
      })
    );

    beforeEach(function() {
      spyOn(subject, 'debouncedFetchOptions').and.callFake(subject.fetchOptions);
    });

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
      expect(subject.state.options).toEqual([['Australia', 'au'], ['Austria', 'at']]);
    });

    it('keeps previously selected options around', function() {
      subject.setState({ value: ['de'], options: [['Germany', 'de']] })

      spyOn($, 'getJSON').and.callFake(function(url, callback) {
        callback([
          { text: 'Australia', value: 'au'},
          { text: 'Austria', value: 'at'}
        ]);
      });

      triggerSearch(subject, 'Aus');
      var australia = $(subject.getDOMNode()).find('.chosen-results li:nth-child(2)');
      australia.trigger('mouseup');
      expect(subject.state.value).toEqual(['de', 'au']);
      expect(subject.state.options).toEqual([
        ['Germany', 'de'],
        ['Australia', 'au'],
        ['Austria', 'at']
      ]);
    });
  });

  describe('preselected selected options', function() {
    describe('for single select', function() {
      var subject = React.addons.TestUtils.renderIntoDocument(
        React.createElement(ui_components.Select, {
          options: [['Germany', 'de'], ['France', 'fr']],
          selected: 'de'
        })
      );

      it('has Germany preselected', function() {
        expect($(subject.getDOMNode()).find('select').val()).toEqual('de');
      });
    });

    describe('for multiple select, passing an array', function() {
      var subject = React.addons.TestUtils.renderIntoDocument(
        React.createElement(ui_components.Select, {
          options: [['Germany', 'de'], ['France', 'fr']],
          selected: ['de'],
          multiple: true
        })
      );

      it('has Germany preselected', function() {
        expect($(subject.getDOMNode()).find('select').val()).toEqual(['de']);
      });
    });

    describe('for multiple select, passing a single value', function() {
      var subject = React.addons.TestUtils.renderIntoDocument(
        React.createElement(ui_components.Select, {
          options: [['Germany', 'de'], ['France', 'fr']],
          selected: 'de',
          multiple: true
        })
      );

      it('has Germany preselected', function() {
        expect($(subject.getDOMNode()).find('select').val()).toEqual(['de']);
      });
    });
  });

  function triggerSearch(node, value) {
    $(node.refs.chosen.getDOMNode()).find('input')
      .val(value)
      .trigger('keyup');
  }
});
