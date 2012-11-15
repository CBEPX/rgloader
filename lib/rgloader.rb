# RubyEncoder v1.0 loader
#
# Get the version and platform information for requiring loading proper
# loader native module.
#
# For ruby 1.8.x there no prefix in module name. So module name will be
#
#  * rgloader.<platform>.[x68_64]
#
# As far I understand, for 1.9.x there two types of modules. Generic and
# Specific one.
#
# From my personal expirience (Oct, 2012) Generic modules, if they really
# designed to work with all versions in 1.9.x branch, not allways works.
#
# For example, when there was no loaders for 1.9.3, generic module raised
# and exception, if you tried to load it. But anyway, from original loader
# code it's clear that RubyEncoder tries to find Specific module, but if
# it fails it tries to load Generic one.
#
# For Generic modules "19" prefix is used:
#
#  * rgloader19.<platform>.[x68_64]
#
# For Specific modules "19x" prefix is used. For example, for 1.9.3 it
# will be something like:
#
#  * rgloader193.<platform>.[x68_64]
#
module RubyEncoderLoader
  # Add a RubyEncoderLoader::LoadError class, to be able to catch
  # RubyEncoder Loader load errors apart of other possible load
  # errors.
  class LoadError < ::LoadError; end

  ruby_version_prefix = RUBY_VERSION.split('.').join
  ruby_version_prefix = '' if ruby_version_prefix.to_i < 190

  # Get the platform name. Ex: "darwin" or "mingw"
  platform_integer, platform_name = RUBY_PLATFORM.scan(/^([A-Za-z0-9_]+)-([A-Za-z_]+)/)[0]

  root = File.expand_path(File.dirname(__FILE__))

  basepath = File.expand_path File.join(root, "..", "rgloader")

  lookups = [
    # 193, darwin, x86_64
    [ruby_version_prefix, platform_name, platform_integer],
    # 193, darwin
    [ruby_version_prefix, platform_name],
    # 19, darwin, x86_64
    [ruby_version_prefix.chop, platform_name, platform_integer],
    # 19, darwin
    [ruby_version_prefix.chop, platform_name]
  ]

  lookups.map! {|signature| File.join(basepath, "rgloader#{signature.join(".")}") }

  loaded = false
  lookups.each do |path|
    begin
      require path
      loaded = true
      break
    rescue ::LoadError => e
    end
  end

  if not loaded
    raise LoadError, "The RubyEncoder loader is not avaliable for this ruby version (#{RUBY_VERSION}) or this platform (#{platform_name}). Please visit the RubyEncoder site (http://www.rubyencoder.com/loaders/) and check that required loader is avaliable and file issue on gem's github page (http://github.com/y8/rgloader). We tried to load:\n\t#{lookups.join("\n\t")}"
  end
end