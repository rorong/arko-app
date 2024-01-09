class FileExportsController < ApplicationController
  before_action :authenticate_user!

  def index
    exported_file = ExportFiles::Main.new(params).export

    # render error if no data present for requested table
    if exported_file == 'Requested data not found'
      flash[:alert] = 'Requested data not found'
      redirect_to root_path and return
    end

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
end
