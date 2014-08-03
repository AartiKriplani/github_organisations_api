class Outputter
  def self.output(organizations)
    headers = ['organization', 'repo', 'repo language']

    file_handler = FileHandler.new(headers, 'test.csv')
    console_handler = ConsoleHandler.new(headers)

    console_handler.write(organizations)
    file_handler.write(organizations)
  end
end