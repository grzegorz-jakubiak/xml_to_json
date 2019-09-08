# typed: false
# frozen_string_literal: true

RSpec.describe XMLToJson::Tags::XMLTag do
  let!(:p_tag) do
    XMLToJson::Tags::XMLTag.new(tag: 'p', attributes: { _class: 'caption' })
  end

  let!(:b_tag) do
    XMLToJson::Tags::XMLTag.new(tag: 'b', attributes: { _class: 'bold-caption', _text: 'Bold Text' })
  end

  it 'creates p tag with no attributes' do
    xml_tag = XMLToJson::Tags::XMLTag.new(tag: 'p', attributes: {})
    expect(xml_tag.tag).to eq('p')
    expect(xml_tag.attributes).to eq({})
  end

  it 'creates p tag with class attribute' do
    expect(p_tag.tag).to eq('p')
    expect(p_tag.attributes).to eq(_class: 'caption')
  end

  it 'adds b tag to p tags attributes' do
    p_tag.add_to_attributes(b_tag.tag, b_tag.attributes)
    expect(p_tag.attributes).to have_key(b_tag.tag)
    expect(p_tag.attributes[b_tag.tag]).to include(b_tag.attributes)
  end
end
