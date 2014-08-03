require 'csv'

class FileHandler
  attr_accessor :headers, :filename
  
  def initialize(headers, filename)
    @headers = headers
    @filename = filename
  end

  def write data
    CSV.open(@filename, "wb") do |csv|
      csv << headers
      data.each do |org|
        org.to_csv.each do |csv_row|
          csv << csv_row
        end
      end
    end
  end

end