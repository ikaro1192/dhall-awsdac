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

in  { rgba
    , rgb
    , transparent = rgba 0 0 0 0
    , black = rgba 0 0 0 255
    , white = rgba 255 255 255 255
    }
