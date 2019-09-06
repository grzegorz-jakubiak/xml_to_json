# frozen_string_literal: true

module XMLToJson
  module Tags
    XMLTag = Struct.new(:tag, :attributes, keyword_init: true)
  end
end
