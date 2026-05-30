-- Pure-description helper: wraps `(name, resource)` into the
-- `{ mapKey, mapValue }` shape Dhall uses to emit a YAML mapping entry.
-- Hoisted out of the examples so callers don't have to redefine it locally.
let Resource = ./Resource.dhall

in  \(name : Text) ->
    \(resource : Resource) ->
      { mapKey = name, mapValue = resource }
