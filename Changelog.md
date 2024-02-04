# Changeslog

## 2020-02-04

- Changed rspec examples from localhost project to JSONPlaceholder API
- Added `to_csv` in array class to convert array to csv
- Added `wrap` in array class to convert hash or nill to an array (Powered by rails core repo)
- Added `keys` in hash class to symbolize and stringify hash keys
- Added `string_colorize` in String class to colorize any string
- Supported csv format you can export the response to csv by `request.csv`

## 2024-02-04

- Upgraded dependencies

1. bundler from `~> 2.0` to `~> 2.5", ">= 2.5.4`
2. rake from `~> 13.0` to `~> 13.1`
3. byebug from `11.1.3` to `11.1.3`
4. rspec from to `3.0` to `3.12`
5. rubocop from `0.93.1` to `1.60`
6. rubocop-performance from `1.8.1` to `1.20.2`
7. vcr from `5.0.0` to `6.2`
8. webmock from `3.6.2` to `3.19.1`
