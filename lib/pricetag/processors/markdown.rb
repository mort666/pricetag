module PriceTag
  module Processors
    module Markdown
      extend Processors::Base

      PriceTag.module_eval do
        class << self
          def html_to_markdown(html, options = {})
            Document.new(html).to_markdown(options)
          end
        end
      end

      PriceTag::Document.class_eval do
        include PriceTag::Processors
        
        def to_markdown(options = {})
          options[:heading_style] ||= :atx
          options[:link_style] ||= :reference
          
          @markdown ||= @xml.dup
          @markdown.search("root > *").each do |node|
            Markdown::process!(node, options)
          end

          output = CGI.unescapeHTML(@markdown.root.content)
          output += Markdown::text_for_references(@references) if options[:link_style] == :reference

          return output
        end
      end

      class << self
        def text_for_references(references)
          output = "\n\n"
          references.each_with_index do |reference, i|
            href, title = reference
            output << "[#{i+1}]: #{href}"
            output << " \"#{title}\"" if title and title != ""
            output << "\n"
          end
          
          return output
        end
        
      private
      
        def text_for_node(node, options = {})
          case tag = node.name.to_sym
            when :h1, :h2, :h3, :h4, :h5, :h6
              style = options[:heading_style]
              style = :atx unless [:h1, :h2].include?(tag)

              case style
                when :setext
                  separator = (tag == :h1 ? "=" : "-")
                  "#{node.text}\n#{separator * node.text.length}"
                when :atx
                  octothorps = "#" * level_for_heading(node)
                  "#{octothorps} #{node.text}"
              end
            when :li
              indentation = "\t" * (indentation_level_for_list_item(node) - 1)
              if node.parent.name == "ol"
                position = node['data-position']
                "#{indentation}#{position}. #{node.text}"
              else
                "#{indentation}* #{node.text}"
              end
            when :blockquote
              nesting = ">" * (indentation_level_for_blockquote(node) + 1)
              nesting + " " + node.text
            when :a
              style = options[:link_style]

              case style
                when :inline
                  if node.text == node['href']
                    "<#{node.text}>"
                  elsif node['href'].match(/mailto:(.+)/)
                    "<#{$1}>"
                  elsif node['title']
                    "[#{node.text.strip}](#{node['href']} #{node['title']})"
                  else
                    "[#{node.text.strip}](#{node['href']})"
                  end
                when :reference
                  "[#{node.text.strip}][#{node['data-reference-number']}]"
              end
            when :img
              if node['title']
                "![#{node['alt']}](#{node['href']} #{node['title']})"
              else
                "![#{node['alt']}](#{node['href']})"
              end
            when :em
              "_#{node.text}_"
            when :strong
              "**#{node.text}**"
            when :pre
              node.text.match(/^\t/) ? node.text : node.to_s
            when :code
              case node.parent.name.to_sym
                when :pre
                  node.text.split(/\n/).collect{|line| "\t\t" + line}.join("\n")
                else
                  "`#{node.text}`"
              end
            when :tt
              "`#{node.text}`"
            when :br
              "  \n"
            when :td, :th
              "#{node.text}|"
            when :thead 
              "#{node.text}|----------|----------|\n"
            when :table, :tbody, :tfooter 
              "#{node.text}"
            when :tr
              "|#{node.text.gsub("\n","")}\n"
            when :hr
              "- - -"
            when :p, :span, :ul, :ol
              node.text
            else
             CGI.unescapeHTML(node.to_s)
          end
        end
      end
    end
  end
end