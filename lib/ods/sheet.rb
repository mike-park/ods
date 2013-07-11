module Ods
  class Sheet
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def name
      content.attribute('name').to_s
    end

    # access by (0,0) = top left
    def [](row_index, col_index)
      row = data[row_index]
      row && row[col_index]
    end

    def rows
      return @rows if @rows
      @rows = []
      src_rows = content.xpath('descendant::table:table-row')

      # ignore trailing empty rows
      while (last_row = src_rows.last) && (Row.new(last_row, self).data.length == 0)
        src_rows.pop
      end

      src_rows.each do |node|
        a_row = Row.new(node, self)
        repeat = node['table:number-rows-repeated'] || 1
        repeat.to_i.times do
          @rows << a_row
        end
      end
      @rows
    end

    def data
      @data ||= rows.map(&:data)
    end

    def csv
      CSV do |csv|
        data.each { |row| csv << row }
      end
    end
  end
end