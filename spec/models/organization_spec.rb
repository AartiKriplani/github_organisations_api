require_relative '../../models/organization'

describe Organization do
  describe '#to_csv' do
    it 'returns repository details as an array' do
      org = Organization.new('example', [{'name' => 'example_repo', 'language' => 'Ruby'}])
      expected_result = [%w(example example_repo Ruby)]
      expect(org.to_csv).to eq expected_result
    end

    it "returns each repository's details as an array" do
      org = Organization.new('example', [{'name' => 'example_repo', 'language' => 'Ruby'},
                                         {'name' => 'example_repo_2', 'language' => 'Java'}])
      expected_result = [%w(example example_repo Ruby), %w(example example_repo_2 Java)]
      expect(org.to_csv).to eq expected_result
    end
  end
end
