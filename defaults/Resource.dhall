let Resource = ../schema/Resource.dhall

let IconFill = ../schema/IconFill.dhall

let BorderChild = ../schema/BorderChild.dhall

let Options = ../schema/Options.dhall

in  { Type = Resource
    , default =
      { Title = ""
      , Icon = ""
      , IconFill = None IconFill
      , Preset = ""
      , Direction = ""
      , Align = ""
      , HeaderAlign = ""
      , Children = [] : List Text
      , BorderChildren = [] : List BorderChild
      , SpanResources = [] : List Text
      , FillColor = ""
      , BorderColor = ""
      , BorderType = ""
      , TitleColor = ""
      , TitleFillColor = ""
      , Font = ""
      , Options = None Options
      }
    }
