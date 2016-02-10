require "middleman-core"

Middleman::Extensions.register :middleman_scavenger do
  require "middleman-scavenger/extension"
  MiddlemanScavenger
end
