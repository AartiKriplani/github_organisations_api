require 'thor'
require './services/github_service'
require './utils/file_handler'
require './utils/console_handler'

class GithubOrganizations < Thor

	def initialize
		super

		headers = ['organization', 'repo', 'repo language']
		@github_service = GithubService.new
		@file_handler = FileHandler.new(headers, 'test.csv')
		@console_handler = ConsoleHandler.new(headers)
	end		

	
	desc 'fetch_data ORGANIZATION_NAMES',"Fetch organization's data from github"
	def fetch_data(*organization_names)
		organizations = organization_names.map do |organization_name|
			@github_service.get_organization organization_name
		end

		console_handler.write(organizations)
		file_handler.write(organizations)
	end

end