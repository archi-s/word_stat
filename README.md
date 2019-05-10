WordStat collects statistics from bukvarix.com on the usual and "exact" request; the number of results in Google on the "exact" phrase entry.
==========

Installation
------------------
```ruby
$ gem install WordStat
```

Before you can use all the features of the library you want to connect a data file with words in ```word_stat/data/words.txt``` and proxy in ```word_stat/data/proxy.txt```

ProxyChecker
------------------
  ProxyChecker checks your proxy list for accessibility and creates a good_proxy.txt file that it uses for parsing.

```ruby
  # check proxy list
  $ bin/run -c or --checker
  # => good_proxy.txt
```

ParserBukvarix
----------------
  ParserBukvarix collects statistics from bukvarix.com

```ruby
  # collect statistics with bukvarix.com
  $ bin/run -b or --bukvarix
  # => bukvarix.csv
```

ParserGoogle
----------------
  ParserGoogle collects statistics from bukvarix.com

```ruby
  # collect statistics with Google
  $ bin/run -g or --google
  # => google.csv
```

License
---------------
The gem is available as open source under the terms of the [MIT License] (https://opensource.org/licenses/MIT).

Author
--------------
Arthur H.
