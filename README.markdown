# Metric [![Build Status](https://secure.travis-ci.org/bittersweet/metric.png)](http://travis-ci.org/bittersweet/metric)

Track simple metrics via [metric.io](metric.io).

## Installation

Add the following anywhere in your Gemfile and run `bundle install`.

``` ruby
gem 'metric'
```

And create the following initializer:

``` ruby
Metric.configure do |config|
  config.api_key = "YOUR_API_KEY"
  config.secret_key = "YOUR_SECRET_KEY"
end
```

Now you are all set to start tracking some metrics!

Note: If you are using Rails it will only track events in Production mode.

## Usage

You can track whatever metric you want, it will automatically show up in your
dashboard.

``` ruby
Metric.track("article_view")
```

You can also add a custom amount to log multiple metrics in one go:

``` ruby
Metric.track("email_notifications", {:amount => 301})
```

If you want to push old statistics into metric.io you can use the date
parameter:

``` ruby
Metric.track("signup", {:date => "20120101"})
```

To give the live event view in your dashboard some more context you can pass in
meta information:

``` ruby
Metric.track("email", {:meta => "user 1021"})
```

## Documentation

Although the code is pretty lightweight and self-explanatory,
[documentation](http://rdoc.info/github/bittersweet/metric/master/frames)
is available via rdoc.info.

## Thanks

[jeffkreeftmeijer](https://github.com/jeffkreeftmeijer) for providing me with
the awesome domainname!
