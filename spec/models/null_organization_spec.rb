require_relative '../../models/null_organization'

describe NullOrganization do
  describe '#to_csv_rows' do
    it 'returns an empty array' do
      org = NullOrganization.new
      expected_result = [['', '', '']]
      expect(org.to_csv_rows).to eq expected_result
    end
  end
end
