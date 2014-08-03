require 'terminal-table'

class ConsoleHandler
  attr_accessor :headers

  def initialize(headers)
    @headers = headers
  end

  def write(data)
    rows = data.inject([]){ |r, row| r+=row.to_csv }
    table = Terminal::Table.new :rows => rows
    puts table
  end

end