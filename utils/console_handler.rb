require 'terminal-table'

module ConsoleHandler

  def write_to_console(data)
    rows = data.inject([]){ |result, org| result += org.to_csv_rows }
    table = Terminal::Table.new :title => 'Github repositories for organizations', :headings => headers, :rows => rows
    puts table
  end

end