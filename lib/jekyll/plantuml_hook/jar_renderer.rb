require 'open3'

module Jekyll
  module PlantumlHook
    # JarRenderer renders PlantUML with given jar file
    class JarRenderer
      def initialize(jar_path:)
        @jar_path = jar_path
      end

      def to_svg(src)
        cmd = [
          'java', '-Dapple.awt.UIElement=true', '-jar', @jar_path, '-tsvg', '-pipe', '-nometadata'
        ]
        stdout_str, status = Open3.capture2(*cmd, stdin_data: src)
        raise "Failed to render PlantUML with jar: #{stdout_str}" unless status.success?
        stdout_str
      end
    end
  end
end
