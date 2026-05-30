let IconFill = ./IconFill.dhall

let BorderChild = ./BorderChild.dhall

let Options = ./Options.dhall

in  { Type : Text
    , Title : Text
    , Icon : Text
    , IconFill : Optional IconFill
    , Preset : Text
    , Direction : Text
    , Align : Text
    , HeaderAlign : Text
    , Children : List Text
    , BorderChildren : List BorderChild
    , SpanResources : List Text
    , FillColor : Text
    , BorderColor : Text
    , BorderType : Text
    , TitleColor : Text
    , TitleFillColor : Text
    , Font : Text
    , Options : Optional Options
    }
