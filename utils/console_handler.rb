require 'terminal-table'

class ConsoleHandler
  attr_accessor :headers

  def initialize(headers)
    @headers = headers
  end

  def write(data)
    rows = data.inject([]){ |r, row| r+=row.to_csv }
    table = Terminal::Table.new :title => "Github repositories for organizations", :headings => @headers, :rows => rows
    puts table
  end

end