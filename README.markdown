# Metric

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
end
```

Now you are all set to start tracking some metrics!

Note: If you are using Rails it will only track events in Production mode.

## Usage

You can track whatever metric you want, it will automatically show up in your
dashboard.

``` ruby
def show
  @article = Article.find(params[:id])
  Metric.track("article_view")
end
```

You can also add a custom amount to log multiple metrics in one go:

``` ruby
def notify(users)
  # send mails to everyone involved
  Metric.track("email_notifications", {:amount => users.count})
end
```

To receive emails whenever a metric gets tracked pass in `trigger => true`

``` ruby
def register
  Metric.track("user_signup", {:trigger => true})
end
```

## Thanks

[jeffkreeftmeijer](https://github.com/jeffkreeftmeijer) for providing me with the awesome domainname!