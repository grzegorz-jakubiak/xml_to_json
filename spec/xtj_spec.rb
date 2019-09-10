# typed: false
# frozen_string_literal: true

RSpec.describe XTJ::Document do
  let(:valid_xml_string) do
    "<div><p class='paragraph'>Hello</p>World!</div>"
  end

  let(:xml_document) do
    XTJ::Document.new(valid_xml_string)
  end

  let(:expected_hash) do
    {
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
          expect(xml_document.to_hash).to eq(expected_hash)
        end
      end

      context 'input file' do
        it 'returns valid hash' do
          file = File.new('spec/test_file/index.html')
          result = JSON.parse(File.read('spec/test_file/result.json'), symbolize_names: true)
          xml_file = XTJ::Document.new(file)
          expect(xml_file.to_hash).to eq(result)
        end
      end
    end

    context 'invalid input' do
      it 'raises ParserError' do
        invalid_xml = XTJ::Document.new('slkdjfsdl')
        expect { invalid_xml.to_hash }.to raise_error(REXML::ParseException, 'Invalid XML')

        invalid_xml = XTJ::Document.new('<movies><movie>sdjkads</movies>')
        expect { invalid_xml.to_hash }.to raise_error(REXML::ParseException)
      end
    end
  end

  context '#to_json' do
    context 'valid input' do
      context 'input string' do
        it 'returns valid json' do
          expect(xml_document.to_json).to eq(expected_hash.to_json)
        end
      end

      context 'input file' do
        it 'returns expected json' do
          file = File.new('spec/test_file/index.html')
          result = File.read('spec/test_file/result.json')
          xml_file = XTJ::Document.new(file)
          expect(xml_file.to_json).to eq(result)
        end
      end
    end

    context 'invalid input' do
      it 'raises ParserError' do
        invalid_xml = XTJ::Document.new('slkdjfsdl')
        expect { invalid_xml.to_json }.to raise_error(REXML::ParseException, 'Invalid XML')

        invalid_xml = XTJ::Document.new('<movies><movie>sdjkads</movies>')
        expect { invalid_xml.to_json }.to raise_error(REXML::ParseException)
      end
    end
  end
end
