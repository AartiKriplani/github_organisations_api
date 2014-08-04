require './models/organization'

class NullOrganization < Organization

  def initialize
  end

  def to_csv_rows
    [['', '', '']]
  end

end