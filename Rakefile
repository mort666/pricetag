require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "pricetag"
  gem.homepage = "http://github.com/mort666/pricetag"
  gem.license = "MIT"
  gem.summary = "Convert HTML into your favorite lightweight markup language"
  gem.description = "PriceTag converts HTML documents into light markup languages. Currently supports Markdown and Textile."
  gem.email = ["m@mattt.me", "mort666@virus.org"]
  gem.authors = ["Mattt Thompson", "Stephen Kapp"]

  gem.add_development_dependency 'nokogiri', '~> 1.14.3'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test
