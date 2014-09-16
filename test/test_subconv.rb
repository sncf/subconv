require 'test/unit'
require 'subconv'

class SubconvTest < Test::Unit::TestCase

  def setup_subtitle
    @subtitle = Subconv::Subtitle.new
    @subtitle.start_time = 1
    @subtitle.end_time = 2
    @subtitle << "Abc"
    @subtitle << "Def"
  end

  def test_micro_dvd_formatter
    setup_subtitle
    formatter = Subconv::MicroDVDFormatter.new( 25 )
    assert_equal "{25}{50}Abc|Def\n", formatter.output_subtitle( @subtitle )
  end

  def test_srt_formatter
    setup_subtitle
    formatter = Subconv::SRTFormatter.new
    assert_equal "1\n00:00:01,000 --> 00:00:02,000\nAbc\nDef\n\n", formatter.output_subtitle( @subtitle )
  end

  def test_subtitle_set_read
    subtitle_set = Subconv::SubtitleSet.new
    subtitle_set.read( File.join( File.dirname(__FILE__), 'fixtures', 'example_input.xml' ) )
    assert_equal 2, subtitle_set.subtitles.length
  end

  # TODO more

end
