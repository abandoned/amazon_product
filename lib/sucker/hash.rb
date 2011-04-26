module Sucker

  # A monkey-patched Hash, safely stashed away in the Sucker namespace.
  class Hash < ::Hash
    class << self

      # Builds a hash from a Nokogiri XML document.
      #
      # In earlier versions of Sucker, I was relying on the XML Mini
      # Nokogiri module in Active Support. This method essentially
      # accomplishes the same.
      #
      # Based on https://gist.github.com/335286
      def from_xml(xml)
        case xml
        when Nokogiri::XML::Document
          new[xml.root.name] = from_xml(xml.root)
        when Nokogiri::XML::Element
          result_hash = new

          xml.attributes.each_pair do |key, attribute|
            result_hash[key] = attribute.value
          end

          xml.children.each do |child|
            result = from_xml(child)

            if child.name == 'text'
              if result_hash.empty?
                return result
              else
                result_hash['__content__'] = result
              end
            elsif result_hash[child.name]
              if result_hash[child.name].is_a? Array
                result_hash[child.name] << result
              else
                result_hash[child.name] = [result_hash[child.name]] << result
              end
            else
              result_hash[child.name] = result
            end
          end

          result_hash
        else
          xml.content.to_s
        end
      end
    end
  end
end
