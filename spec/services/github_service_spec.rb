require_relative '../../services/github_service'

describe GithubService do
  describe '#get_organization' do
    context 'when successful' do
      it 'returns the organization' do
        org_name = 'github'
        organization = GithubService.new.get_organization(org_name)

        expect(organization).to be_a_kind_of(Organization)
      end
    end
  end
end