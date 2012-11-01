module PriceTag
  module Processors
    module Textile
      extend Processors::Base

      PriceTag.module_eval do
        class << self
          def html_to_textile(html, options = {})
            Document.new(html).to_textile(options)
          end
        end
      end

      PriceTag::Document.class_eval do
        include PriceTag::Processors

        def to_textile(options = {})
          options[:link_style] ||= :inline
          options[:ignore_styles] ||= true

          @textile ||= @xml.dup
          @textile.search("root > *").each do |node|
            Textile::process!(node, options)
          end

          output = CGI.unescapeHTML(@textile.root.content)
          output += Markdown::text_for_references(@references) if options[:link_style] == :reference

          return output
        end
      end

      INLINE_TAG_SYMBOLS = {
        :span   => "%",
        :em     => "_",
        :i      => "__",
        :strong => "*",
        :b      => "**",
        :cite   => "??",
        :del    => "-",
        :ins    => "+",
        :sup    => "^",
        :sub    => "~"
      }

      class << self
        def text_for_references(references)
          output = "\n\n"
          references.each_with_index do |reference, i|
            href, title = reference
            output << "[#{i+1}]#{href}\n"
          end

          return output
        end

      private

        def text_for_node(node, options = {})
          case tag = node.name.to_sym
            when :h1, :h2, :h3, :h4, :h5, :h6
              "#{node.name}. #{node.text}"
            when :li
              "#{(node.parent.name == "ol" ? "#" : "*") * indentation_level_for_list_item(node)} #{node.text}"
            when :td
              "|#{node.text}|"
            when :blockquote
              "bq. #{node.text}"
            when :a
              style = options[:link_style]

              case style
                when :inline
                  if node.text.match(/^\!/)
                   "#{node.text.strip}:#{node['href']}"
                  else
                    "\"#{node.text.strip}\":#{node['href']}"
                  end
              end
            when :img
              if node['title']
                "!#{node['href']}(#{node['title']})!"
              else
                "!#{node['href']}!"
              end
            when :span, :em, :i, :strong, :b, :cite, :del, :ins, :sup, :sub
              attributes = inline_attributes_for_node(node, options)
              symbol = INLINE_TAG_SYMBOLS[tag]
              "#{symbol}#{attributes}#{node.text}#{symbol}"
            when :acronym
              "#{node.text}(#{node['title']})"
            when :code
              node.parent.name.to_sym == :pre ? node.to_s : "@#{node.text}@"
            when :tt
              "@#{node.text}@"
            when :br
              " \n"
            when :table 
              "\n#{node.text}\n"       
            when :tr
              "#{node.text}\n"
            when :p, :ul, :ol, 
              node.text
            else
             CGI.unescapeHTML(node.to_s)
          end
        end

      private

        def inline_attributes_for_node(node, options = {})
          return nil if node.attributes.empty?

          attributes = ""

          if node.attributes["id"] and node.attributes["class"]
            attributes << "(#{node.attributes["class"]}##{node.attributes["id"]})"
          elsif attributes["id"]
            attributes << "(##{node.attributes["id"]})"
          elsif attributes["class"]
            attributes << "(#{node.attributes["class"]})"
          end

          attributes << "[#{node.attributes["lang"]}]" if node.attributes["lang"]
          attributes << "{#{node.attributes["style"]}}" if node.attributes["style"]

          return attributes
        end
      end
    end
  end
end