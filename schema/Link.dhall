let ArrowHead = ./ArrowHead.dhall

let Labels = ./Labels.dhall

in  { Source : Text
    , Target : Text
    , SourcePosition : Text
    , TargetPosition : Text
    , SourceArrowHead : Optional ArrowHead
    , TargetArrowHead : Optional ArrowHead
    , Type : Text
    , LineWidth : Natural
    , LineColor : Text
    , LineStyle : Text
    , Labels : Optional Labels
    }
