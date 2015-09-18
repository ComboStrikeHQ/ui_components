class Styleguide
  def self.components
    UiComponents::Engine.components_paths.map do |path|
      path.basename.to_s.camelize + 'Cell'
    end.sort.map(&:constantize)
  end

  def self.patterns
    Dir['app/views/styleguide/patterns/*'].each_with_object({}) do |file, obj|
      pattern_name = File.basename(file, '.slim').titleize
      obj[pattern_name] = Rails.root.join(file)
    end
  end
end
