require 'terminal-table'

module ConsoleHandler
  def write_to_console(data)
    rows = data.inject([]){ |result, row| result += row.to_csv }
    table = Terminal::Table.new :title => 'Github repositories for organizations', :headings => headers, :rows => rows
    puts table
  end

end