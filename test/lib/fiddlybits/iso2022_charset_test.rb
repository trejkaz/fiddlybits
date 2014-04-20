require 'test_helper'

class Iso2022CharsetTest < ActiveSupport::TestCase
  #TODO: Remove this circular dependency. This works around it.
  Fiddlybits::Charset

  test "decoding ISO-2022-JP" do
    assert_equal "かな漢字", decode('1B 24 42 24 2B 24 4A 34 41 3B 7A 1B 28 4A', Fiddlybits::Iso2022Charset::ISO_2022_JP)
  end

  test "decoding ISO-2022-KR" do
    assert_equal "김치", decode('1B 24 29 43 0E 31 68 44 21 0F', Fiddlybits::Iso2022Charset::ISO_2022_KR)
  end

private

  def decode(hex, charset)
    data = Fiddlybits::Hex.hex_to_binary(hex)
    string = ''
    charset.decode(data).each do |fragment|
      string << fragment.string if fragment.is_a?(Fiddlybits::Charset::DecodedData)
    end
    string
  end
end