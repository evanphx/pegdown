require 'test/unit'

require 'pegdown'

class TestPegdown < Test::Unit::TestCase
  def test_parse
    pd = Pegdown.new "it worked"
    unless pd.parse
      pd.raise_error
    end


    p pd.result

    flunk
  end
end
