require 'thor'
require './services/github_service'
require './utils/file_handler'
require './utils/console_handler'

class GithubOrganizations < Thor

	desc 'fetch_data ORGANIZATION_NAMES',"Fetch organization's data from github"
	def fetch_data(*organization_names)
		github_service = GithubService.new
		organizations = organization_names.map do |organization_name|
			github_service.get_organization organization_name
		end
		output(organizations)
	end

	private

	def output(organizations)
		headers = ['organization', 'repo', 'repo language']

		file_handler = FileHandler.new(headers, 'test.csv')
		console_handler = ConsoleHandler.new(headers)

		console_handler.write(organizations)
		file_handler.write(organizations)
	end

end