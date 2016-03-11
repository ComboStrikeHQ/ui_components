# frozen_string_literal: true
desc 'Run the styleguide on :port (defaults to 3999).'
task :styleguide, %i(port) do |_, args|
  FileUtils.cd(UiComponents::Engine.root.join('spec', 'dummy')) do
    port = args[:port] || 3999
    exec "bundle exec rails s -p #{port}"
  end
end
