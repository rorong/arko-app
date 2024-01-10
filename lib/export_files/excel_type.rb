# frozen_string_literal: true

module ExportFiles
  # generate export file for requested data in CSV format
  class ExcelType
    attr_accessor :data, :table

    def initialize(table = '')
      @table = table
      @data = table.constantize.all rescue []
    end

    def generate
      return "Requested data not found" unless data.present?

      generate_excel_data(data)
    end

    private

    # create data for Excel export
    def generate_excel_data(data)
      package = Axlsx::Package.new
      wb = package.workbook
      wb.add_worksheet(name: 'Data Export') do |sheet|
        # Add header row excluding specified columns
        sheet.add_row @data.first.attributes.except('created_at', 'updated_at').keys

        # Add data rows excluding specified columns
        @data.each { |record| sheet.add_row record.attributes.except('created_at', 'updated_at').values }
      end

      package.to_stream.read
    end
  end
end
