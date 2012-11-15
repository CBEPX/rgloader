require "bundler/gem_tasks"
require "fileutils"
require 'net/http'
require 'rubygems/package'
require 'zlib'

task :prepare do
  archive_name = "rgloader.tar.gz"

  root = Pathname.new(File.expand_path(File.dirname(__FILE__)))
  # Remove current versions of RGLoaders
  puts "Cleaning files..."
  FileUtils.rm_rf root.join("lib").join("rgloader").join("ext")
  FileUtils.rm_rf root.join(archive_name)

  # Download rgloaders from RubyEncoder website
  Net::HTTP.start("rubyencoder.com") do |http|
    puts "Downloading #{archive_name} http://rubyencoder.com/support/files/#{archive_name}"
    target = open root.join(archive_name), "w"

    begin
      http.request_get("/support/files/#{archive_name}") do |resp|
        resp.read_body do |segment|
          target.write(segment)
        end
      end
    ensure
      target.close
    end
  end

  puts "Extracting archive..."
  gzip = Zlib::GzipReader.open(root.join(archive_name))

  # Unpack archive
  Gem::Package::TarReader.new(gzip).each do |entry|
    FileUtils.mkdir_p File.dirname(entry.full_name)

    target = open entry.full_name, "wb"
    target.write entry.read
  end

  puts "Removing archive..."

  FileUtils.rm_rf root.join(archive_name)

  FileUtils.rm_rf root.join("rgloader").join("loader.rb")
end