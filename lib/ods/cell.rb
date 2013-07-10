module Ods
  class Cell
    attr_reader :row, :content

    def initialize(content, row)
      @content = content
      @row = row
    end

    def value
      value_type = content['office:value-type']
      #puts "value_type=#{value_type}"
      case value_type
        when nil, 'string'
          text
        when 'date'
          Date.strptime(content['office:date-value'], "%Y-%m-%d")
        when 'boolean'
          content['office:boolean-value'] == 'true' ? true : false
        when 'float'
          str = content['office:value']
          if str.match(/\./)
            str.to_f
          else
            str.to_i
          end
        when 'percentage'
          content['office:value'].to_f
        else
          warn "Unknown type: #{value_type} [#{text}]"
      end
    end

    def text
      content.text
    end
  end
end