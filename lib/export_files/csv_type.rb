# frozen_string_literal: true

module ExportFiles
  # generate export file for requested data in CSV format
  class CsvType
    attr_accessor :data, :table

    def initialize(table = '')
      @table = table
      @data = table.constantize.all rescue []
    end

    def generate
      return "Requested data not found" unless data.present?

      generate_csv_data(data)
    end

    private

    # create data for CSV export
    def generate_csv_data(data)
      CSV.generate(headers: true) do |csv|
        # Add header row excluding specified columns
        csv << data.first.attributes.except('created_at', 'updated_at').keys
      
        # Add data rows excluding specified columns
        data.each do |record|
          csv << record.attributes.except('created_at', 'updated_at').values
        end
      end
    end
  end
end
