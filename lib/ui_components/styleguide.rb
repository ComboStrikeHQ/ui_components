module UiComponents
  class Styleguide
    # TODO: Implement attributes in cells and remove respective classes from
    # this list.
    EXCLUDED_COMPONENTS = [::SelectCell,
                           ::CheckboxListCell,
                           ::DateRangeCell,
                           ::MarkdownTextareaCell]

    def self.components
      component_paths =
        Dir.glob(File.join(File.expand_path('../../../app/cells', __FILE__), '*.rb'))
      component_class_names = component_paths.map do |p|
        Pathname.new(p).basename.to_s.sub(/.rb\Z/, '').camelize
      end

      component_classes = component_class_names
        .select { |name| name.ends_with?('Cell') }
        .map(&:constantize)

      component_classes - EXCLUDED_COMPONENTS
    end
  end
end
