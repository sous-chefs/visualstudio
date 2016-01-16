require 'rubocop/rake_task'
require 'foodcritic'
require 'rspec/core/rake_task'

task default: [:version, :rubocop, :foodcritic, :spec]

task :version do
  IO.write('version.txt', (ENV['BUILD_NUMBER'] ? "1.0.#{ENV['BUILD_NUMBER']}" : '1.0.1'))
end

FoodCritic::Rake::LintTask.new do |t|
  t.options = {
    cookbook_paths: '.',
    search_gems: true }
end

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.rspec_opts = ['--color', '-f documentation', '-tunit']
end

RuboCop::RakeTask.new
