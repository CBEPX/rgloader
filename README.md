# RGloader

Gemified version of RubyEncoder loaders.

## Usage

While encoding pass the following code to `-j` argument when encoding your scripts with RubyEncoder:

	"begin;require \"rubygems\";require \"rgloader\";_f=\"rgloader\";break;rescue ::LoadError;raise \"Please install RubyEncoder loaders gem: gem install rgloader\";end;"

Then just add `gem "rgloader"` in your Gemfile. Now you can just use RubyEncoded files, without caring about where to place `rgloader` folder.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
