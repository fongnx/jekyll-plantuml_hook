require 'socket'
prefix = Pry::Helpers::Text.bright_magenta(Socket.gethostname)

Pry.config.prompt = [
  proc { |*a| prefix + Pry::DEFAULT_PROMPT[0].call(*a) },
  proc { |*a| prefix + Pry::DEFAULT_PROMPT[1].call(*a) }
]
