require 'thor'
require 'timecop'

load File.dirname(__FILE__) + '/../github_organizations.thor'

RSpec::Matchers.define :match_console_output do |expected_output|
  match do |actual_console_output|
    actual_console_output =~ /| #{expected_output[0]}      | #{expected_output[1]} | #{expected_output[2]}          |/
  end
end
RSpec::Matchers.define :match_csv_output do |expected_output|
  match do |actual_console_output|
    actual_console_output.include? expected_output
  end
end

describe GithubOrganizations do
  describe '#fetch_data' do
    before do
      Timecop.freeze(Time.local(2014, 8, 3, 12, 0, 0))
      @original_stdout = $stdout
      $stdout = @fake = StringIO.new
    end

    after do
      Timecop.return
      orgs_file = File.dirname(__FILE__) + '/../org_data_1407047400.csv'
      File.delete(orgs_file) if File.exist?(orgs_file)
      $stdout = @original_stdout
    end

    it 'writes data to console for organization that exists and empty line for non existent orgs' do
      VCR.use_cassette('successful_with_missing_org') do
        GithubOrganizations.new.fetch_data('goderma', 'non-existent')
        expect(@fake.string).to match 'Github repositories for organizations'
        expect(@fake.string).to match_console_output ['organization', 'repo', 'repo language']
        expect(@fake.string).to match_console_output %w(goderma doctorapi-ruby Ruby)
        expect(@fake.string).to match_console_output %w(goderma doctorapi-status Ruby)
      end
    end

    it 'writes data to file for organization that exists and empty line for non existent orgs' do
      VCR.use_cassette('successful_with_missing_org') do
        GithubOrganizations.new.fetch_data('goderma', 'non-existent')
        csv_file = CSV.read('org_data_1407047400.csv')
        expect(csv_file).to match_csv_output ["organization", "repo", "repo language"]
        expect(csv_file).to match_csv_output ["goderma", "doctorapi-ruby", "Ruby"]
        expect(csv_file).to match_csv_output ["goderma", "goderma-status", "Ruby"]
        expect(csv_file).to match_csv_output ["", "", ""]
      end
    end
  end
end