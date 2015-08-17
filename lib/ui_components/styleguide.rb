module UiComponents
  class Styleguide
    def self.components
      #Dir.glob(File.join(File.expand_path('../../../app/cells', __FILE__), '*.rb')).map do |p|
      #  Pathname.new(p).basename.to_s.sub(/.rb\Z/, '').camelize
      #end.select { |name| name.ends_with?('Cell') }.map(&:constantize)
      [MarkdownReadonlyCell]
    end
  end
end
