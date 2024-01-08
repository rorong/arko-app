class FileExportController < ApplicationController
  require 'axlsx'
  require 'zip'

  before_action :authenticate_user!
  before_action :fetch_data_to_export

  def generate_export
    # render error if no data present for requested table
    unless @data.present?
      flash[:alert] = 'Requested data not found'
      redirect_to root_path and return
    end

    respond_to do |format|
      format.html
      format.csv do
        send_data generate_csv_data(@data), filename: "csv_data_export_#{Time.now.to_i}.csv"
      end
      format.xlsx do
        render template: 'file_export/generate_export', formats: [:xlsx], handlers: [:axlsx], filename: "excel_data_export_#{Time.now.to_i}.xlsx"
      end
    end
  end

  private

  # fetch data of the requested table
  def fetch_data_to_export
    @data = params[:selected_option].constantize.all rescue []
  end

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
