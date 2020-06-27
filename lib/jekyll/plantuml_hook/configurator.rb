require_relative 'jar_renderer'
require_relative 'server_renderer'

module Jekyll
  module PlantumlHook
    # Configurator provides methods to set up PlantumlHook
    class Configurator
      class << self
        def register_hook
          ::Jekyll::Hooks.register(%i[pages post], :post_render) do |page|
            renderer = get_plantuml_renderer(page.site.config)    
            if page.path.end_with?('.md') || !page.path.include?('.') then            
              case get_config(page.site.config, 'parser')
              when 'nokogiri'
                require 'nokogiri'
                process_with_nokogiri(page, renderer)
              when 'oga'
                require 'oga'
                process_with_oga(page, renderer)
              else
                raise 'Unknown parser config for PlantUMLHook'
              end
            end
          end
        end

        private

        def get_plantuml_renderer(site_config)
          plantuml_url = get_config(site_config, 'plantuml_url')
          plantuml_jar_path = get_config(site_config, 'plantuml_jar_path')

          if !plantuml_jar_path.nil?
            JarRenderer.new(jar_path: plantuml_jar_path)
          elsif !plantuml_url.nil?
            ServerRenderer.new(url: plantuml_url)
          else
            raise 'cannot configure PlantumlHook'
          end
        end

        def process_with_nokogiri(page, renderer)
          doc = ::Nokogiri::HTML.parse(page.output)

          doc.css('code.language-plantuml').each_with_index do |node, _i|
            svg = renderer.to_svg(node.text)
            node.parent.replace(::Nokogiri::XML.parse(svg).root)
          end

          page.output = doc.to_html
        end

        def process_with_oga(page, renderer)
          doc = ::Oga.parse_html(page.output)
          doc.css('pre > code.language-plantuml').each do |node|
            svg = renderer.to_svg(node.text)
            svg_elm = ::Oga.parse_xml(svg).at_xpath('/svg')
            node.parent.replace(svg_elm)
          end
          page.output = Oga::XML::Generator.new(doc).to_xml
        end

        def get_config(config, name)
          val = ENV['PLANTUML_HOOK_' + name.upcase]
          return val if !val.nil? && !val.empty?
          config.dig('plantuml_hook', name)
        end
      end
    end
  end
end
