module Metric
  class Util
    def self.escape(string)
      URI.escape(string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def self.build_query_string(object, prefix = nil)
      string = []
      object.each_pair do |key, value|
        k = prefix ? "#{prefix}[#{key}]" : key
        next if value.nil?
        if value.is_a?(Hash)
          string << build_query_string(value, k)
        else
          string << "#{escape(k)}=#{escape(value.to_s)}"
        end
      end
      string.join("&")
    end
  end
end
