# frozen_string_literal: true

describe SafeRandom do
  describe '.generate_code' do
    it 'defaults to the safe alphabet' do
      sample = 1000.times.map { described_class.generate_code }
      sample.each do |code|
        expect(code).to eq(code.downcase)
        expect(code.chars).not_to include('a', 'e', 'i', 'o', 'u', 'l', 'v')
      end
    end

    it 'generates codes of specified length' do
      length = 6
      code = described_class.generate_code(length)
      expect(code.length).to eq(6)
    end

    it 'uses the provided character set' do
      charset = ['X']
      code = described_class.generate_code(16, charset)
      expect(code.chars.uniq).to eq(charset)
    end
  end
end
