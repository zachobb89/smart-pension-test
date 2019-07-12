require 'spec_helper'
require './file_parser'
require './parse'

RSpec.describe FileParser do
  let(:file_path) { 'webserver_test.log' }
  subject { described_class.new(file_path) }

  describe '#most_viewed' do
    let(:expected_results) do
      [['/home', 4], ['/index', 4], ['/about', 1]]
    end

    context 'when most views is requested' do
      it 'should produce an ordered list of most views' do
        expect(subject.get_most_views).to eq(expected_results)
      end
    end
  end

  describe '#unique_views' do
    let(:expected_results) do
      [['/home', 4], ['/index', 4], ['/about', 1]]
    end

    context 'when unique views is requested' do
      it 'should produce an ordered list of unique views' do
        expect(subject.get_unique_views).to eq(expected_results)
      end
    end
  end
end
