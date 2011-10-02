require 'rubygems'
require 'minitest/autorun'
require 'pp'

require 'pegdown'
require 'rdoc'

class TestPegdown < MiniTest::Unit::TestCase

  def setup
    @RM = RDoc::Markup
  end

  def mu_pp obj
    s = ''
    s = PP.pp obj, s
    s.force_encoding Encoding.default_external if defined? Encoding
    s.chomp
  end
  
  def test_parse
    doc = parse 'it worked'

    expected = @RM::Document.new(
      @RM::Paragraph.new('it worked'))

    assert_equal expected, doc
  end

  def parse text
    Pegdown.parse text
  end

end

