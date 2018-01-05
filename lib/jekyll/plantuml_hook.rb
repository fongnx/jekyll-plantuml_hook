require_relative 'plantuml_hook/version'
require_relative 'plantuml_hook/configurator'

module Jekyll
  # PlantUMLHook provides Jekyll hook to render PlantUML in code
  module PlantumlHook
  end
end

Jekyll::PlantumlHook::Configurator.register_hook
