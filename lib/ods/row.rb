module Ods
  class Row
    attr_reader :sheet, :content

    def initialize(content, sheet)
      @content = content
      @sheet = sheet
    end

    def [](index)
      data[index]
    end

    def cols
      return @cols if @cols
      @cols = []
      content.xpath('table:table-cell').each do |node|
        repeat = node['table:number-columns-repeated'] || 1
        a_cell = Cell.new(node, self)
        repeat.to_i.times do
          @cols << a_cell
        end
      end
      @cols
    end

    def data
      @data ||= begin
        values = if cols.last.value == ''
                   cols.reject { |col| col == cols.last }
                 else
                   cols
                 end.map(&:value)
        while values.length > 0 && values.last == ''
          values.pop
        end
        values
      end
    end
  end
end
