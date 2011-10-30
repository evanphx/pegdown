require 'rubygems'
require 'minitest/autorun'
require 'pp'

require 'pegdown'
require 'rdoc'
require 'rdoc/markup/block_quote'

class TestPegdown < MiniTest::Unit::TestCase

  def setup
    @RM = RDoc::Markup

    @parser = Pegdown.new
  end

  def mu_pp obj
    s = ''
    s = PP.pp obj, s
    s.force_encoding Encoding.default_external if defined? Encoding
    s.chomp
  end

  def test_parse_block_quote
    doc = parse <<-BLOCK_QUOTE
> this is
> a block quote
    BLOCK_QUOTE

    expected = @RM::Document.new(
      @RM::BlockQuote.new("this is\n", "a block quote\n"))

    assert_equal expected, doc
  end

  def test_parse_block_quote_continue
    doc = parse <<-BLOCK_QUOTE
> this is
a block quote
    BLOCK_QUOTE

    expected = @RM::Document.new(
      @RM::BlockQuote.new("this is\n", "a block quote\n"))

    assert_equal expected, doc
  end

  def test_parse_block_quote_newline
    doc = parse <<-BLOCK_QUOTE
> this is
a block quote

    BLOCK_QUOTE

    expected = @RM::Document.new(
      @RM::BlockQuote.new("this is\n", "a block quote\n", "\n"))

    assert_equal expected, doc
  end

  def test_parse_block_quote_separate
    doc = parse <<-BLOCK_QUOTE
> this is
a block quote

> that continues
    BLOCK_QUOTE

    expected = @RM::Document.new(
      @RM::BlockQuote.new("this is\n", "a block quote\n",
                          "\n",
                          "that continues\n"))

    assert_equal expected, doc
  end

  def test_parse_heading_atx
    doc = parse "# heading\n"

    expected = @RM::Document.new(
      @RM::Heading.new(1, "heading"))

    assert_equal expected, doc
  end

  def test_parse_heading_setext_dash
    doc = parse <<-MD
heading
---
    MD

    expected = @RM::Document.new(
      @RM::Heading.new(2, "heading"))

    assert_equal expected, doc
  end

  def test_parse_heading_setext_equals
    doc = parse <<-MD
heading
===
    MD

    expected = @RM::Document.new(
      @RM::Heading.new(1, "heading"))

    assert_equal expected, doc
  end

  def test_parse_html_address
    @parser.html = true

    doc = parse "<address>Links here</address>"

    expected = @RM::Document.new(
      @RM::Paragraph.new("<address>Links here</address>"))

    assert_equal expected, doc
  end

  def test_parse_html_address_no_html
    doc = parse "<address>Links here</address>"

    expected = @RM::Document.new(
      @RM::Paragraph.new("Links here"))

    assert_equal expected, doc
  end

  def test_parse_list_bullet
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

  def test_parse_list_bullet_continue
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

  def test_parse_list_number
    doc = parse <<-MD
1. one
1. two
    MD

    expected = @RM::Document.new(
      @RM::List.new(:NUMBER, *[
        @RM::ListItem.new(nil, @RM::Paragraph.new("one\n")),
        @RM::ListItem.new(nil, @RM::Paragraph.new("two\n"))]))

    assert_equal expected, doc
  end

  def test_parse_list_number_continue
    doc = parse <<-MD
1. one

1. two
    MD

    expected = @RM::Document.new(
      @RM::List.new(:NUMBER, *[
        @RM::ListItem.new(nil, @RM::Paragraph.new("one\n")),
        @RM::ListItem.new(nil, @RM::Paragraph.new("two\n"))]))

    assert_equal expected, doc
  end

  def test_parse_paragraph_indent_one
    doc = parse <<-MD
 text
    MD

    expected = @RM::Document.new(@RM::Paragraph.new(" text"))

    assert_equal expected, doc
  end

  def test_parse_paragraph_indent_two
    doc = parse <<-MD
  text
    MD

    expected = @RM::Document.new(@RM::Paragraph.new(" text"))

    assert_equal expected, doc
  end

  def test_parse_paragraph_indent_three
    doc = parse <<-MD
   text
    MD

    expected = @RM::Document.new(@RM::Paragraph.new(" text"))

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

  def test_parse_rule_dash
    doc = parse "- - -\n\n"

    expected = @RM::Document.new(@RM::Rule.new(1))

    assert_equal expected, doc
  end

  def test_parse_rule_underscore
    doc = parse "_ _ _\n\n"

    expected = @RM::Document.new(@RM::Rule.new(1))

    assert_equal expected, doc
  end

  def test_parse_rule_star
    doc = parse "* * *\n\n"

    expected = @RM::Document.new(@RM::Rule.new(1))

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

  def test_parse_verbatim
    doc = parse <<-MD
    text
    MD

    expected = @RM::Document.new(@RM::Verbatim.new(["text\n"]))

    assert_equal expected, doc
  end

  def parse text
    @parser.parse text
  end

end

