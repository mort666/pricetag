module PriceTag
  module Processors
    module Base
      def process!(node, options = {})
        return if node.text?
      
        node.children.each do |child|
          process!(child, options)
        end
  
        text = text_for_node(node, options)
        node.replace(node.document.create_text_node(text))
      end
      
    private
    
      def level_for_heading(node)
        node.name.match(/[123456]/)[0].to_i rescue 0
      end
    
      def indentation_level_for_list_item(node)        
        node.ancestors.select{|t| ["ol", "ul"].include?(t.name)}.length
      end
      
      def indentation_level_for_blockquote(node)        
        node.ancestors.select{|t| t.name == "blockquote"}.length
      end
    end
  end
end