require "aws/s3"
require "date"

module Nlag
  class SermonList
    def connect
      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV["AWS_KEY_ID"],
        :secret_access_key => ENV["AWS_SECRET_KEY"])
    end

    def connected?
      AWS::S3::Base.connected?
    end

    def each
      connect if not connected?
      bucket = AWS::S3::Bucket.find("nlagaudio")
      list = bucket.collect {|s3_obj| AudioFile.on(s3_obj)}
      list.sort.reverse_each {|ea| yield ea}
    end
  end

  class AudioFile
    attr_writer :s3_object

    def self.on(s3object)
      inst = new
      inst.s3_object = s3object
      inst
    end

    def name
      @s3_object.key
    end

    def url
      ten_minutes = 60 * 10
      @s3_object.url(:expires_in => ten_minutes)
    end

    def <=>(other)
      date <=> other.date
    end

    protected
    def date
      raw_text = name.split(" ")[0]
      Date.parse(raw_text)
    rescue
      Date.new  # Return an old date if unparsable
    end
  end
end
