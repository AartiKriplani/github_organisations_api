require 'csv'

module FileHandler
  def write_to_file(data)
    CSV.open(filename, 'wb') do |csv|
      csv << headers
      data.each do |org|
        org.to_csv.each do |csv_row|
          csv << csv_row
        end
      end
    end
  end

end