require 'spec_helper'
require './view'

RSpec.describe View do
  # let(:file_path) { './spec/webserver_test.log' }
  # let(:file_parser) { FileParser.new(file_path)}
  let(:entries) do
    { '/index' => ['444.701.448.104', '316.433.849.805', '802.683.925.780',
                   '184.123.665.067'],
      '/about' => ['126.318.035.038'],
      '/home' => ['382.335.626.855', '802.683.925.780', '451.106.204.921',
                  '715.156.286.412'] }
  end
  subject { described_class.new(entries) }

  describe '#views' do
    let(:expected_results) do
      [['/home', 4], ['/index', 4], ['/about', 1]]
    end

    context 'when most views is requested' do
      it 'should produce the expected results in an array' do
        expect(subject.views(unique: true)).to eq(expected_results)
      end
    end
  end

  describe '#views_indiv_page' do
    let(:expected_result) do
      { '/home' => 4 }
    end

    context 'when views of an indivdual page is requested' do
      it 'should produce the expected result in a hash' do
        expect(subject.views_indiv_page('/home', unique: true)).to eq(expected_result)
      end
    end
  end
end
