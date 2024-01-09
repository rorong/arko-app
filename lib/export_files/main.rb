# frozen_string_literal: true

module ExportFiles
  # generate export file for requested data in CSV/Excel format
  class Main
    attr_accessor :table, :format

    def initialize(params)
      @table = params[:selected_option]
      @format = params[:format]
    end

    def export
      case format
      when 'csv'
        ExportFiles::CsvType.new(table).generate
      when 'xlsx'
        ExportFiles::ExcelType.new(table).generate
      else
        []
      end
    end
  end
end
