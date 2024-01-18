# SimpleRequest

`simple_request` founded to make both `HTTP` and `HTTPS` request simple as it should to be

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Installation](#installation)
- [Usage](#usage)
    - [GET Request](#get-request)
    - [POST Request](#post-request)
    - [PUT, Patch Request](#put-patch-request)
    - [DELETE Request](#delete-request)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_request', '~> 0.1.4'
```

Then bundle it
```powershell
$ bundle
```

Install it independently:
```powershell
$ gem install simple_request
```

## Usage

#### GET Request
```ruby
request = SimpleRequest.get(url: 'https://api.xxxxx.xxxxxx.com/v1/cities', body: {}, headers: {'API-ACCESSOR' => 'xxxxxxx-xxxxx-xxxx-xxxx-x'})
request.json
# OUTPUT
# {
#     "message"=>"Data found",
#     "cities"=>{
#         "data"=>[
#             {
#                 "id"=>"8",
#                 "type"=>"city",
#                 "attributes"=>{
#                     "name_en"=>"Mohali",
#                     "status"=>"inactive"
#                 }
#             }
#         ]
#     }
# }
request.plain
# OUTPUT
# "{\"message\":\"Data found\",\"cities\":{\"data\":[{\"id\":\"8\",\"type\":\"city\",\"attributes\":{\"name_en\":\"Mohali\",\"name_ar\":\"موهالي\",\"status\":\"inactive\"}}]},\"pagination\":{\"current_page\":1,\"next_page\":2,\"previous_page\":null,\"total_pages\":6,\"per_page\":1,\"total_entries\":6}}"

request.scheme        # => "https"
request.host          # => "api.xxxxx.xxxxxx.com"
request.port          # => 80
request.request_uri   # => "/v1/cities?limit=1"
request.path          # => "/v1/cities"
request.query         # => "limit=1"
```

#### POST Request
```ruby

request = SimpleRequest.post(
    url: 'https://api.xxxxx.xxxxxx.com/v1/cities',
    body: {"city"=>{"name_ar"=>"المكلا", "name_en"=>"Mukalla", "status"=>"active"}, "locale"=>"en"},
    headers: {"Authorization"=> "Bearer xxxxxxxxxxxx.xxxxxxxx.xxxxxxxx"}
)
request.json
# OUTPUT
# {"message"=>"City created successfully", "city"=>{"data"=>{"id"=>"10", "type"=>"city_details", "attributes"=>{"name_en"=>"Mukalla", "name_ar"=>"المكلا", "suggested_time"=>0, "suggested"=>false, "status"=>"active"}}}}
request.plain
# OUTPUT
#  "{\"message\":\"City created successfully\",\"city\":{\"data\":{\"id\":\"10\",\"type\":\"city_details\",\"attributes\":{\"name_en\":\"Mukalla\",\"name_ar\":\"المكلا\",\"suggested_time\":0,\"suggested\":false,\"status\":\"active\"}}}}"

request.csv
# This will export the whole response you can specify the path you want to export by passing the exact path as string split by comma
# example
request.csv('city,data,attributes')
```


#### PUT, Patch Request
```ruby

request = SimpleRequest.put(
    url: 'https://api.xxxxx.xxxxxx.com/v1/cities/10',
    body: {"city"=>{"name_ar"=>"حضرموت", "name_en"=>"Hadramut", "status"=>"active"}, "locale"=>"en"},
    headers: {"Authorization"=> "Bearer xxxxxxxxxxxx.xxxxxxxx.xxxxxxxx"}
)

request = SimpleRequest.patch(
    url: 'https://api.xxxxx.xxxxxx.com/v1/cities/10',
    body: {"city"=>{"name_ar"=>"حضرموت", "name_en"=>"Hadramut", "status"=>"active"}, "locale"=>"en"},
    headers: {"Authorization"=> "Bearer xxxxxxxxxxxx.xxxxxxxx.xxxxxxxx"}
)

request.json
# OUTPUT
# {"message"=>"City updated successfully", "city"=>{"data"=>{"id"=>"10", "type"=>"city_details", "attributes"=>{"name_en"=>"Hadramut", "name_ar"=>"حضرموت", "suggested_time"=>0, "suggested"=>false, "status"=>"active"}}}}
request.plain
# OUTPUT
# "{\"message\":\"City updated successfully\",\"city\":{\"data\":{\"id\":\"10\",\"type\":\"city_details\",\"attributes\":{\"name_en\":\"Hadramut\",\"name_ar\":\"حضرموت\",\"suggested_time\":0,\"suggested\":false,\"status\":\"active\"}}}}"
```

#### DELETE Request
```ruby
request = SimpleRequest.delete(
    url: 'https://api.xxxxx.xxxxxx.com/v1/cities/10',
    body: {},
    headers: {"Authorization"=> "Bearer xxxxxxxxxxxx.xxxxxxxx.xxxxxxxx"}
)

request.json
# OUTPUT
# {"message"=>"City deleted successfully", "id"=>10}
request.plain
# OUTPUT
# "{\"message\":\"City deleted successfully\",\"id\":10}"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports, pull requests new ideas are welcome on GitHub at [Simple Request Repo](https://github.com/MajedBojan/simple_request). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SimpleRequest project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/simple_request/blob/master/CODE_OF_CONDUCT.md).
