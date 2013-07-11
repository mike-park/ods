require 'thor'
require 'csv'

module Ods
  class Cli < Thor
    method_option :sheet, default: 0
    method_option :file, required: true
    method_option :verbose
    desc 'csv', 'dumps --sheet x (0 by default) in csv format'
    def csv
      file = Ods::File.open(options[:file])
      sheet = file.sheets[options[:sheet].to_i]
      sheet && sheet.csv
    end
  end
end