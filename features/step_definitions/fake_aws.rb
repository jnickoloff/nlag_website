class Object
  remove_const(:AWS) if defined?(AWS)

  module AWS
    module S3
      class Base
        def self.establish_connection!(hash)
        end

        def self.connected?
          false
        end
      end

      class S3Object
        attr_accessor :key
        attr_writer :url

        def url(hash)
          @url
        end
      end

      class Bucket
        def self.find(name)
          Bucket.new
        end

        def each
          objects.each {|ea| yield ea}
        end

        def collect
          list = []
          each {|ea| list << (yield ea)}
          list
        end

        def objects
          obj1 = S3Object.new
          obj1.key = "2012.2.25 - Blarg Baz - Great Sermon.mp3"
          obj1.url = "http://test_url1"

          obj2 = S3Object.new
          obj2.key = "2012.4.30 - Mr. Foo Bar - Que?.mp3"
          obj2.url = "http://test_url2"

          [obj2, obj1]
        end
      end
    end
  end
end
