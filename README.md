# Mayan

A Ruby gem for performing calculations and conversions with the ancient Mayan calendar system. This gem supports the three main components of the Mayan calendar: the Long Count, Tzolkin (sacred calendar), and Haab (solar calendar).

## Features

- Convert between Gregorian dates and Mayan Long Count dates
- Calculate Tzolkin dates (260-day sacred calendar)
- Calculate Haab dates (365-day solar calendar)
- Full support for Mayan calendar glyphs and day names
- Accurate conversions using the GMT correlation constant

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add mayan
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install mayan
```

## Usage

### Long Count Calendar

The Long Count is the Mayan method of tracking long periods of time, represented as five numbers (baktun.katun.tun.winal.kin).

```ruby
require 'mayan'

# Convert a Gregorian date to Long Count
gregorian_date = Date.new(2012, 12, 21)
long_count = Mayan::LongCount::Date.from_gregorian(gregorian_date)
puts long_count.to_s  # => "13.0.0.0.0"

# Create a Long Count date directly
long_count = Mayan::LongCount::Date.new(13, 0, 0, 0, 0)

# Convert Long Count back to Gregorian
gregorian = long_count.to_gregorian
puts gregorian  # => #<Date: 2012-12-21>

# Get total days since Mayan epoch
puts long_count.days  # => 1872000
```

### Tzolkin Calendar

The Tzolkin is a 260-day sacred calendar combining 13 numbers with 20 day names.

```ruby
# Convert Long Count to Tzolkin
long_count = Mayan::LongCount::Date.from_gregorian(Date.new(2012, 12, 21))
tzolkin = long_count.to_tzolkin
puts tzolkin.to_s  # => "4 Ajaw"

# Access Tzolkin components
puts tzolkin.number  # => 4
puts tzolkin.glyph.name  # => "Ajaw"

# Create a Tzolkin date directly
glyph = Mayan::Tzolkin::Glyph.new("Imix'")
tzolkin = Mayan::Tzolkin::Date.new(1, glyph)
puts tzolkin.to_s  # => "1 Imix'"
```

Available Tzolkin day names: Imix', Ik', Ak'bal, K'an, Chikchan, Kimi, Manik', Lamat, Muluk, Ok, Chuwen, Eb, Ben, Hix, Men, K'ib', Kaban, Etz'nab', Kawak, Ajaw

### Haab Calendar

The Haab is a 365-day solar calendar with 18 months of 20 days plus a 5-day month called Wayeb'.

```ruby
# Convert Long Count to Haab
long_count = Mayan::LongCount::Date.from_gregorian(Date.new(2012, 12, 21))
haab = long_count.to_haab
puts haab.to_s  # => "3 K'ank'in"

# Access Haab components
puts haab.number  # => 3
puts haab.glyph.name  # => "K'ank'in"

# Create a Haab date directly
glyph = Mayan::Haab::Glyph.new("Pop")
haab = Mayan::Haab::Date.new(0, glyph)
puts haab.to_s  # => "0 Pop"
```

Available Haab month names: Pop, Wo', Sip, Sotz', Sek, Xul, Yaxk'in', Mol, Ch'en, Yax, Sak', Keh, Mak, K'ank'in, Muwan', Pax, K'ayab', Kumk'u, Wayeb'

### Complete Example

```ruby
require 'mayan'
require 'date'

# Convert today's date to all three Mayan calendar formats
gregorian = Date.today
long_count = Mayan::LongCount::Date.from_gregorian(gregorian)
tzolkin = long_count.to_tzolkin
haab = long_count.to_haab

puts "Gregorian: #{gregorian}"
puts "Long Count: #{long_count}"
puts "Tzolkin: #{tzolkin}"
puts "Haab: #{haab}"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nazamoresco/mayan. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nazamoresco/mayan/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mayan project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nazamoresco/mayan/blob/main/CODE_OF_CONDUCT.md).
