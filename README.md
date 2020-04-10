# NessusSaxParser
Parse XML Nessus report for version 3.0 of .nessus file.

## Dependency
nokogiri

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nessus_sax_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nessus_sax_parser

## Usage

create the following script importing nessus_sax_parser:
```ruby
    doc = NessusSaxParser::MyDocument.new
    parser = Nokogiri::XML::SAX::Parser.new(doc)

    parser.parse_file(<your_nessus_fileV3_with_path>)

    all_nessusid = doc.plugin_set
    all_targets = doc.targets
    puts all_nessusid
    puts all_targets
```
    

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Augusto Costa/nessus_sax_parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

