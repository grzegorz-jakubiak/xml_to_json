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
    @e = {:html=>{:_xmlns=>"http://www.w3.org/1999/xhtml", :_lang=>"en-us", :head=>{:meta=>{:_charset=>"UTF-8"}, :title=>{:@text=>"CV Template Title"}}, :body=>{:section=>[{:h1=>{:@text=>"Your name"}, :hr=>{}, :ul=>{:li=>[{:@text=>"Date of Birth: 29.02.1985"}, {:@text=>"E-mail: your.name@example.com"}, {:@text=>"Phone number: 782129891"}, {:i=>{:_class=>"github", :@text=>"github"}, :@text=>" github.com/your.name"}]}, :img=>{:_src=>"https://picsum.photos/id/760/200/200"}}, {:h2=>{:@text=>"Education"}, :hr=>{}, :ul=>{:li=>[{:@text=>"19.02.2013 - 19.03.2014 Your University - Master's degree"}, {:@text=>"19.02.2013 - 19.03.2014 Your University - Bachelor's degree"}]}}, {:h2=>{:@text=>"Work Experience"}, :hr=>{}, :ul=>{:li=>[{:@text=>"19.02.2013 - today Your Company"}, {:@text=>"19.02.2013 - 19.03.2014 Your Internship"}]}}]}}} 
  end

  context '#to_hash' do
    context 'valid input' do
      context 'input string' do
        it 'returns valid hash' do
          expect(@xml_document.to_hash).to eq(@expected_hash)
        end
      end

      context 'input file' do
        
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
