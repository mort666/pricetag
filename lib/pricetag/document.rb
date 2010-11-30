module PriceTag
  class Document
    def initialize(html)
      @xml = Nokogiri::XML("<root>" + html + "</root>") do |config|
        config.strict.noent
      end

      @references = []
      @xml.search("a").each do |link|
        @references << [link['href'], link['title']]
        link['data-reference-number'] = @references.length.to_s
      end
    end
  end
end