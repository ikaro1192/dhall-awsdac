let Definition = ../schema/Definition.dhall

let DefinitionIcon = ../schema/DefinitionIcon.dhall

let DefinitionLabel = ../schema/DefinitionLabel.dhall

let DefinitionFill = ../schema/DefinitionFill.dhall

let DefinitionBorder = ../schema/DefinitionBorder.dhall

in  { Type = Definition
    , default =
      { Icon = None DefinitionIcon
      , Label = None DefinitionLabel
      , Fill = None DefinitionFill
      , Border = None DefinitionBorder
      , HeaderAlign = ""
      , Directory = { Source = "", Path = "" }
      , ZipFile = { SourceType = "", Source = "", Path = "", Url = "" }
      , CFn = { HasChildren = False }
      }
    }
