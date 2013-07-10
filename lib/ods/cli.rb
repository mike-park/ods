require 'thor'
require 'csv'

module Ods
  class Cli < Thor
    option :sheet, default: 0
    option :file, required: true
    option :verbose
    desc 'csv', 'dumps --sheet x (0 by default) in csv format'
    def csv
      file = Ods::File.open(options[:file])
      sheet = file.sheets[options[:sheet].to_i]
      sheet && sheet.csv
    end
  end
end