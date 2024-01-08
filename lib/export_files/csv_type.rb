# frozen_string_literal: true

module ExportFiles
  # generate export file for requested data in CSV format
  class CsvType
    attr_accessor :data

    def initialize(data = [])
      @data = data
    end

    def generate
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
