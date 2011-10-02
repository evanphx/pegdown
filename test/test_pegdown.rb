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

  def test_parse_bullet_list
    doc = parse <<-MD
* one
* two
    MD

    expected = @RM::Document.new(
      @RM::List.new(:BULLET, *[
        @RM::ListItem.new(nil, @RM::Paragraph.new("one\n")),
        @RM::ListItem.new(nil, @RM::Paragraph.new("two\n"))]))

    assert_equal expected, doc
  end

  def test_parse_para
    doc = parse "it worked\n"

    expected = @RM::Document.new(
      @RM::Paragraph.new("it worked"))

    assert_equal expected, doc
  end

  def test_parse_para_multiline
    doc = parse "one\ntwo"

    expected = @RM::Document.new(
      @RM::Paragraph.new("one\n", "two"))

    assert_equal expected, doc
  end

  def test_parse_para_two
    doc = parse "one\n\ntwo"

    expected = @RM::Document.new(
      @RM::Paragraph.new("one"),
      @RM::Paragraph.new("two"))

    assert_equal expected, doc
  end

  def test_parse_plain
    doc = parse "it worked"

    expected = @RM::Document.new(
      @RM::Paragraph.new("it worked"))

    assert_equal expected, doc
  end

#  def test_parse_style
#    doc = parse <<-MD
#<style></style>
#    MD
#
#    expected = @RM::Document.new(
#      @RM::Paragraph.new("it worked"))
#
#    assert_equal expected, doc
#  end

  def parse text
    Pegdown.parse text
  end

end

