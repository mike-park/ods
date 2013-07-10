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
      row = rows[row_index]
      if row.kind_of?(Array)
        puts "bad #{row_index} #{col_index}"
        #puts row
      end
      row.nil? ? nil : row.cols[col_index]
    end

    def rows
      return @rows if @rows
      @rows = []
      content.xpath('descendant::table:table-row').each do |node|
        a_row =  Row.new(node, self)
        repeat = node['table:number-rows-repeated'] || 1
        repeat.to_i.times do
          @rows << a_row
        end
      end
      @rows
    end

    def csv
      CSV do |csv|
        rows.each do |row|
          csv << row.cols.map(&:value)
        end
      end
    end
  end
end