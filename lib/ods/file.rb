require 'zip/zip'
require 'nokogiri'

module Ods
  class File
    XPATH_SHEETS = '//office:body/office:spreadsheet/table:table'

    def self.open(path)
      ods_file = new(path)
      if block_given?
        yield ods_file
      else
        ods_file
      end
    end

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def sheets
      content.root.xpath(XPATH_SHEETS).map {|sheet| Sheet.new(sheet) }
    end

    private

    def content
      @content ||= unzip_content
    end

    def unzip_content
      Zip::ZipFile.open(path) do |zip|
        Nokogiri::XML::Document.parse(zip.read('content.xml'))
      end
    end
  end
end