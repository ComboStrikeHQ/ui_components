//= require ui_components

describe('ui_components.Select', function() {
  var subject = function(props) {
    return React.addons.TestUtils.renderIntoDocument(React.createElement(ui_components.Select, props))
  };
  var $subject = _.compose($, React.findDOMNode, subject);

  it("sets the hidden input's name", function() {
    expect($subject({ name: 'foo' }).find('.is-searchable > input').attr('name')).toEqual('foo')
  });

  it('does not create a hidden select element', function() {
    expect($subject().find('select').length).toEqual(0);
  });

  it('sets the pre-selected value', function() {
    var props = { options: [['Foo', 'foo']],
                  value: 'foo',
                  name: 'bar' };
    expect($subject(props).find('[name="bar"]').val()).toEqual('foo');
  });

  describe('normalizeOptions()', function() {
    it('normalizes an array of strings', function(){
      var props = { options: ['foo', 'bar', 'baz'] };

      expect(subject(props).state.options).toEqual([
        { value: 'foo', label: 'foo' },
        { value: 'bar', label: 'bar' },
        { value: 'baz', label: 'baz' }
      ]);
    });

    it('normalizes an array of arrays of strings', function(){
      var props = { options: [['Foo', 'foo'], ['Bar', 'bar'], ['Baz', 'baz']] };

      expect(subject(props).state.options).toEqual([
        { value: 'foo', label: 'Foo' },
        { value: 'bar', label: 'Bar' },
        { value: 'baz', label: 'Baz' }
      ]);
    });

    it('does not touch the options otherwise', function(){
      var props = { options: [
        { value: 'foo', label: 'Foo' },
        { value: 'bar', label: 'Bar' },
        { value: 'baz', label: 'Baz' }
      ]};

      expect(subject(props).state.options).toEqual([
        { value: 'foo', label: 'Foo' },
        { value: 'bar', label: 'Bar' },
        { value: 'baz', label: 'Baz' }
      ]);
    });
  });

  describe('multiselect', function() {
    var component = subject({
      name: 'foo',
      multiple: true,
      value: [1, 3],
      options: [['One', 1], ['Two', 2], ['Three', 3]]
    });

    it('maintains a hidden select element with all the selected options', function() {
      var $select = $(component.getDOMNode()).find('select');
      expect($select.length).toEqual(1);
      expect($select.attr('name')).toEqual('foo');
      expect(_.pluck($select.find('option[selected]'), 'value')).toEqual(['1', '3']);
    });

    it("does not set the hidden input field's name if anything is selected", function() {
      var hiddenInput = function() { return $(component.getDOMNode()).find('input[type="hidden"]') };
      expect(hiddenInput().attr('name')).toBe(undefined);
      component.setState({ value: [] });
      expect(hiddenInput().attr('name')).toBe('foo');
    });

    it('sets the pre-selected values', function() {
      var props = { options: [['Foo', 'foo']],
                    value: ['foo'],
                    name: 'bar',
                    multiple: true };
      expect($subject(props).find('[name="bar"]').val()).toEqual(['foo']);
    });

  });
});
