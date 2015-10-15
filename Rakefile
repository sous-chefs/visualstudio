require 'tailor/rake_task'
require 'foodcritic'
require 'rspec/core/rake_task'

task :default => [:version, :tailor, :foodcritic, :spec]

task :version do
  IO.write('version.txt', (ENV['BUILD_NUMBER'] ? "0.0.#{ENV['BUILD_NUMBER']}" : '1.0.0'))
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

Tailor::RakeTask.new
