require 'foodcritic'
require 'tailor/rake_task'
require 'rspec/core/rake_task'
require 'daptiv-chef-ci/vagrant_task'

task :default => [:build_number, :tailor, :foodcritic, :spec]

task :build_number do
  IO.write('version.txt', (ENV['BUILD_NUMBER'] ? "0.0.#{ENV['BUILD_NUMBER']}" : '0.0.1'))
end

FoodCritic::Rake::LintTask.new do |t|
  t.options = {
    :cookbook_paths => '.',
    :search_gems => true }
end

Tailor::RakeTask.new
Vagrant::RakeTask.new

RSpec::Core::RakeTask.new do |task|
    task.pattern = "spec/**/*_spec.rb"
    task.rspec_opts = [ '--color', '-f documentation' ]
    task.rspec_opts << '-tunit'
end
