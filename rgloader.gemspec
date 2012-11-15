# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rgloader/version'

Gem::Specification.new do |gem|
  gem.name          = "rgloader"
  gem.version       = RubyEncoderLoader::VERSION
  gem.authors       = ["Alexey Bondar"]
  gem.email         = ["y8@ya.ru"]
  gem.homepage      = "http://github.com/y8/rgloader"
  gem.description   = %q{Gemified RubyEncoder loaders.}
  gem.summary       = %q{RubyEncoder loaders in form of gems}

  # TODO: Add proper platform specification, based on already implemented
  # set of loaders. We even can create separate gemfiles to delegate platform
  # resolution to Rubygems instead of using custom built loader.
  # gem.platform      = Gem::Platform::RUBY

  # From RubyEncoder Overview page (http://rubyencoder.com/overview.html):
  #   RubyEncoder works with the following versions: Ruby 1.8.6, 1.8.7, 1.9.0, 1.9.1, 1.9.2 are fully supported.
  #
  # Also, 1.9.3 loader was released in Jan of 2012.
  # gem.required_ruby_version = ['>= 1.8.6', "<= 1.9.3"]

  gem.files = [
    "Gemfile",
    "LICENSE.txt",
    "Rakefile",
    "README.md",
    "lib/rgloader.rb",
    "lib/rgloader/version.rb",
    Dir["rgloader/**"]
  ].flatten

  gem.require_paths = ["lib"]
end
