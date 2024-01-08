# frozen_string_literal: true

module ExportFiles
  # generate export file for requested data in CSV/Excel format
  class Main
    attr_accessor :data, :format

    def initialize(data = [], format = '')
      @data = data
      @format = format
    end

    def export
      case format
      when 'csv'
        ExportFiles::CsvType.new(data).generate
      when 'xlsx'
        ExportFiles::ExcelType.new(data).generate
      else
        []
      end
    end
  end
end
