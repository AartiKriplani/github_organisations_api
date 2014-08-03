require './utils/file_handler'
require './utils/console_handler'

class Outputter

  extend FileHandler
  extend ConsoleHandler

  def self.output(organizations)
    write_to_console(organizations)
    write_to_file(organizations)
  end

  def self.headers
    ['organization', 'repo', 'repo language']
  end

  def self.filename
    "org_data_#{Time.now.to_i}.csv"
  end

end