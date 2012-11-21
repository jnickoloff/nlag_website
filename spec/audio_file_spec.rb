require "nlag"

include Nlag

describe AudioFile do
  before do
    @s3_obj = mock("S3Object")
    @s3_key = "2012.2.25 - Author - Great Sermon.mp3"
    @s3_url = "http://testurl"
    @file1 = AudioFile.on(@s3_obj)

    @s3_obj2 = mock("S3Object #2")

    @file2 = AudioFile.on(@s3_obj2)
  end

  context "regarding sorting" do
    before do
      @s3_obj.should_receive(:key).any_number_of_times.and_return(@s3_key)
      @s3_obj2.should_receive(:key).any_number_of_times.and_return("2012.2.24 sdslkjnflkjelkjfe")
    end

    it "can be sorted" do
      [@file1, @file2].sort.should == [@file2, @file1]
    end

    it "can sort 3 objects" do
      s3_obj3 = mock("S3Object")
      s3_obj3.should_receive(:key).any_number_of_times.and_return("2012.10.30 - yar")
      file3 = AudioFile.on(s3_obj3)
      [@file2, file3, @file1].sort.should == [@file2, @file1, file3]
    end

    it "doesnt change if already in correct order" do
      [@file2, @file1].sort.should == [@file2, @file1]
    end

    it "sorts unparsable dates first" do
      bad = mock("badly named S3Object")
      bad.should_receive(:key).any_number_of_times.and_return("dateless_filename")
      bad_audio = AudioFile.on(bad)

      [@file2, @file1, bad_audio].sort.should == [bad_audio, @file2, @file1]
    end
  end

  it "can return the songs name and s3 url" do
    @s3_obj.should_receive(:key).and_return(@s3_key)
    ten_minutes = 60 * 10
    @s3_obj.should_receive(:url).
      with(hash_including(:expires_in => ten_minutes)).
      and_return(@s3_url)
    @file1.name.should == @s3_key
    @file1.url.should == @s3_url
  end
end

