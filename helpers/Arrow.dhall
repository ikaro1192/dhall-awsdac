let ArrowHead = ../schema/ArrowHead.dhall

let open
    : Optional ArrowHead
    = Some
        { Type = "Open"
        , Length = None Double
        , Width = None Text
        }

let default
    : Optional ArrowHead
    = Some
        { Type = "Default"
        , Length = None Double
        , Width = None Text
        }

in  { open, default }
