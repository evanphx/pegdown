require 'test/unit'

require 'pegdown'

class TestPegDown < Test::Unit::TestCase
  def test_parse
    pd = PegDown.new "it worked"
    unless pd.parse
      pd.raise_error
    end


    p pd.result

    flunk
  end
end
