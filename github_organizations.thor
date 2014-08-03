require 'thor'
require './services/github_service'
require './utils/file_handler'
require './utils/console_handler'

class GithubOrganizations < Thor
	
	desc 'fetch_data ORGS',"Fetch organization's data from github"
	def fetch_data(*organization)
		github_service = GithubService.new
		headers = ['organization', 'repo', 'repo language']
		file_handler = FileHandler.new(headers, 'test.csv')
		console_handler = ConsoleHandler.new(headers)
		
		organizations = organization.map do |org_name|
			github_service.get_organization org_name
		end

		console_handler.write(organizations)
		file_handler.write(organizations)
	end

end