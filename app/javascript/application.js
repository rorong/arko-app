// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
  const tableToExport = document.getElementById('table_to_export');

  if (tableToExport) {
    tableToExport.addEventListener('change', function(event) {
      event.preventDefault();

      var csvLink = document.getElementById('generate-csv-link');
      var csvButtonHref = csvLink.href;
      csvButtonHref = csvButtonHref.replace(/(\?|&)selected_option=[^&]*/, "");
      var separator = csvButtonHref.includes('?') ? '&' : '?';
      csvLink.href = csvButtonHref + separator + "selected_option=" + event.target.value;

      var excelLink = document.getElementById('generate-excel-link');
      var excelButtonHref = excelLink.href;
      excelButtonHref = excelButtonHref.replace(/(\?|&)selected_option=[^&]*/, "");
      separator = excelButtonHref.includes('?') ? '&' : '?';
      excelLink.href = excelButtonHref + separator + "selected_option=" + event.target.value;
    });
  }
});
