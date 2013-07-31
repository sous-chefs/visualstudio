require 'foodcritic'
require 'tailor/rake_task'

task :default => [:lint]
task :lint => [:tailor, :foodcritic]

desc 'Run foodcritic with default rule set.'
task :foodcritic do
  # TODO: use Daptiv foodcritic gem for extended rules
  extended_rules_dir = '../chef-repo/foodcritic_rules'
  if Dir.exists?(extended_rules_dir)
    included_rules = [extended_rules_dir]
  else
    included_rules = []
  end

  cookbook_paths = ['.']
  options = { :tags => [], :fail_tags => %w(any), :include_rules => included_rules }
  review = ::FoodCritic::Linter.new.check(cookbook_paths, options)
  if review.failed?
    STDERR.puts(review)
    STDERR.puts('ERROR: Foodcritic Failed!')
    raise(SystemExit, 1)
  else
    puts 'Foodcritic Passed'
  end
end

desc 'Run tailor code style tool.'
task :tailor do
  tailor_opts=[]
  failure = Tailor::CLI.run(tailor_opts)
  if failure
    STDERR.puts('ERROR: Tailor Failed!')
    raise(SystemExit, 1)
  else
    puts 'Tailor Passed'
  end
end

#TODO: Vagrant task
