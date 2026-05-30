let rgba
    : Natural -> Natural -> Natural -> Natural -> Text
    = \(r : Natural) ->
      \(g : Natural) ->
      \(b : Natural) ->
      \(a : Natural) ->
            "rgba("
        ++  Natural/show r
        ++  ","
        ++  Natural/show g
        ++  ","
        ++  Natural/show b
        ++  ","
        ++  Natural/show a
        ++  ")"

let rgb
    : Natural -> Natural -> Natural -> Text
    = \(r : Natural) ->
      \(g : Natural) ->
      \(b : Natural) ->
        rgba r g b 255

-- Saturating clamp into [0, 255]. Built from `Natural/subtract`, which is
-- saturating at 0, so the only way to express `min 255 n` without `if`.
let clamp255
    : Natural -> Natural
    = \(n : Natural) -> Natural/subtract (Natural/subtract n 255) 255

let rgbaClamped
    : Natural -> Natural -> Natural -> Natural -> Text
    = \(r : Natural) ->
      \(g : Natural) ->
      \(b : Natural) ->
      \(a : Natural) ->
        rgba (clamp255 r) (clamp255 g) (clamp255 b) (clamp255 a)

let rgbClamped
    : Natural -> Natural -> Natural -> Text
    = \(r : Natural) ->
      \(g : Natural) ->
      \(b : Natural) ->
        rgbaClamped r g b 255

in  { rgba
    , rgb
    , rgbaClamped
    , rgbClamped
    , clamp255
    , transparent = rgba 0 0 0 0
    , black = rgba 0 0 0 255
    , white = rgba 255 255 255 255
    }
