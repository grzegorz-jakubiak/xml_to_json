# frozen_string_literal: true

RSpec.describe XMLToJson::Document do
  let(:valid_xml_string) do
    "<div><p class='paragraph'>Hello</p>World!</div>"
  end

  before :each do
    @xml_document = XMLToJson::Document.new(valid_xml_string)
    @expected_hash = {
      div: {
        p: {
          _class: 'paragraph',
          :@text => 'Hello'
        },
        :@text => 'World!'
      }
    }
  end

  context '#to_hash' do
    context 'valid input' do
      context 'input string' do
        it 'returns valid hash' do
          expect(@xml_document.to_hash).to eq(@expected_hash)
        end
      end

      context 'input file' do
        it 'returns valid hash' do
          file = File.new('spec/test_file/index.html')
          result = JSON.parse(File.read('spec/test_file/result.json'), symbolize_names: true)
          xml_document = XMLToJson::Document.new(file)
          expect(xml_document.to_hash).to eq(result)
        end
      end
    end
  end

  context '#to_json' do
    context 'valid input' do
      context 'input string' do
        it 'returns valid json' do
          expect(@xml_document.to_json).to eq(@expected_hash.to_json)
        end
      end

      context 'input file' do
        it 'returns expected json' do
          file = File.new('spec/test_file/index.html')
          result = File.read('spec/test_file/result.json')
          xml_document = XMLToJson::Document.new(file)
          expect(xml_document.to_json).to eq(result)
        end
      end
    end
  end
end
