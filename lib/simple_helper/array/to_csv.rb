# frozen_string_literal: true

require 'csv'

# Usage [{first_name: 'MaJeD', last_name: 'BoJaN'}, {first_name: 'Mohammed', last_name: 'majed'}].to_csv('file_name.csv')
class Array
  def to_csv(csv_filename = 'file_name.csv')
    CSV.open(csv_filename, 'wb') do |csv|
      csv << first.keys
      each do |hash|
        csv << hash.values # _at(*keys)
      end
    end
  end
end
