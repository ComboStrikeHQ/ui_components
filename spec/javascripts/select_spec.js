//= require ui_components

describe('ui_components.Select', function() {
  var subject = function(props) {
    return React.addons.TestUtils.renderIntoDocument(React.createElement(ui_components.Select, props))
  };

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
});
