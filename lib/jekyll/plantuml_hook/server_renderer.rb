require 'open-uri'
require 'zlib'

module Jekyll
  module PlantumlHook
    # ServerRenderer renders PlantUML with given PlantUML server
    class ServerRenderer
      def initialize(url:)
        @url = url
      end

      def to_svg(src)
        url = gen_url(@url, src, 'svg')
        open(url) do |f|
          body = f.read
          raise "invalid response: #{body}" unless success?(f)
          body
        end
      end

      private

      def success?(f)
        f.metas['content-type'] == ['image/svg+xml']
      end

      def gen_url(url, text, format)
        [url, format, "~1" + compress_text(text)].join('/')
      end

      def compress_text(text)
        result = StringIO.new
        compressed = Zlib::Deflate.deflate(text)
        compressed.chars.each_slice(3) do |bytes|
          converted = padded(bytes, 3, 0).map { |b| b.ord & 0xFF }
          result << append3bytes(*converted)
        end
        result.string
      end

      def padded(array, n, default)
        padding_size = n - array.size
        padding_size <= 0 ? array : (array + Array.new(padding_size, default))
      end

      # https://github.com/hsanson/asciidoctor-plantuml/blob/ca6e94f2e6aae4ea0be773b5642eab01074749ed/lib/asciidoctor-plantuml/plantuml.rb#L205
      def append3bytes(b1, b2, b3)
        [
          b1 >> 2,
          ((b1 & 0x3) << 4) | (b2 >> 4),
          ((b2 & 0xF) << 2) | (b3 >> 6),
          b3 & 0x3F
        ].map { |c| encode6bit(c & 0x3F).chr }.join
      end

      def encode6bit(b)
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_'[b] || '?'
      end
    end
  end
end
