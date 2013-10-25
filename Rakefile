require 'tailor/rake_task'
require 'foodcritic'
require 'daptiv-chef-ci/vagrant_task'

task :lint => [:tailor, :foodcritic]
task :default => [:lint]

FoodCritic::Rake::LintTask.new do |t|
  t.options = {
    :cookbook_paths => '.',
    :search_gems => true }
end

Tailor::RakeTask.new
Vagrant::RakeTask.new
