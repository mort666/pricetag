module PriceTag
  class Document
    def initialize(html)
      @xml = Nokogiri::HTML("<root>" + html + "</root>") do |config|
        config.strict.noent
      end

      @references = []
      @xml.search("a").each do |a|
        @references << [a['href'], a['title']]
        a['data-reference-number'] = @references.length.to_s
      end
      
      @xml.search("li").each do |li|
        li['data-position'] = (li.parent.search("li").index(li) + 1).to_s
      end
    end
  end
end