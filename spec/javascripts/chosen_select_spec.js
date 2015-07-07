//= require ui_components

describe('ui_components.Select', function() {
  describe('select multiple', function() {
    var subject = React.addons.TestUtils.renderIntoDocument(
      React.createElement(ui_components.Select, { multiple: true })
    );

    it('sets the initial state', function() {
      expect(subject.state.value).toEqual([]);
    });
  });

  describe('select single', function() {
    var subject = React.addons.TestUtils.renderIntoDocument(
      React.createElement(ui_components.Select, { multiple: false })
    );

    it('sets the initial state', function() {
      expect(subject.state.value).toEqual('');
    });
  });
});
