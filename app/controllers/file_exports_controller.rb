class FileExportsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_data_to_export

  def index
    # render error if no data present for requested table
    unless @data.present?
      flash[:alert] = 'Requested data not found'
      redirect_to root_path and return
    end

    exported_file = ExportFiles::Main.new(@data, params[:format]).export

    respond_to do |format|
      format.html
      format.csv do
        send_data exported_file, filename: "csv_data_export_#{Time.now.to_i}.csv"
      end
      format.xlsx do
        send_data exported_file, filename: "excel_data_export_#{Time.now.to_i}.xlsx", type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      end
    end
  end

  private

  # fetch data of the requested table
  def fetch_data_to_export
    @data = params[:selected_option].constantize.all rescue []
  end
end
