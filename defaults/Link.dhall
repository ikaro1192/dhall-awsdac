let Link = ../schema/Link.dhall

let ArrowHead = ../schema/ArrowHead.dhall

let Labels = ../schema/Labels.dhall

in  { Type = Link
    , default =
      { SourcePosition = ""
      , TargetPosition = ""
      , SourceArrowHead = None ArrowHead
      , TargetArrowHead = None ArrowHead
      , Type = ""
      , LineWidth = 0
      , LineColor = ""
      , LineStyle = ""
      , Labels = None Labels
      }
    }
