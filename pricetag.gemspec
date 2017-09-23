# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mort666-pricetag}
  s.version = "0.1.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mattt Thompson", "Stephen Kapp"]
  s.description = %q{PriceTag converts HTML documents into light markup languages. Currently supports Markdown and Textile.}
  s.email = %q{m@mattt.me mort666@virus.org}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/pricetag.rb",
    "lib/pricetag/document.rb",
    "lib/pricetag/processors.rb",
    "lib/pricetag/processors/base.rb",
    "lib/pricetag/processors/markdown.rb",
    "lib/pricetag/processors/textile.rb",
    "lib/pricetag/version.rb",
    "test/helper.rb"
  ]
  s.homepage = %q{http://github.com/mort666/pricetag}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.summary = %q{Convert HTML into your favorite lightweight markup language}
  s.test_files = [
    "test/helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["> 1.5.1"])
      s.add_development_dependency(%q<nokogiri>, ["> 1.8"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["> 1.5.1"])
      s.add_dependency(%q<nokogiri>, ["> 1.8"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["> 1.5.1"])
    s.add_dependency(%q<nokogiri>, ["> 1.8"])
  end
end
