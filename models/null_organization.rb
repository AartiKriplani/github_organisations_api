require './models/organization'

class NullOrganization < Organization

  def initialize
  end

  def to_csv
    [['', '', '']]
  end

end