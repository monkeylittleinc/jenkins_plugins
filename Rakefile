require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'

RuboCop::RakeTask.new(:rubocop)

FoodCritic::Rake::LintTask.new(:foodcritic)

RSpec::Core::RakeTask.new(:chefspec) do |t|
  t.rspec_opts = [].tap do |a|
    a.push('--exclude-pattern \'spec/jenkins-plugins/**/*_spec.rb\'')
  end.join(' ')
end

RSpec::Core::RakeTask.new(:serverspec) do |_t|
  sh 'vagrant up'
end

task default: [:rubocop, :foodcritic, :chefspec]
task all: [:default, :serverspec]
