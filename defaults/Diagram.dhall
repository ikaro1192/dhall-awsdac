let DiagramSchema = ../schema/Diagram.dhall

let DefinitionFile = ../schema/DefinitionFile.dhall

let Resource = ../schema/Resource.dhall

let Link = ../schema/Link.dhall

in  { Type = DiagramSchema
    , default =
      { Diagram =
        { DefinitionFiles = [] : List DefinitionFile
        , Resources =
            [] : List { mapKey : Text, mapValue : Resource }
        , Links = [] : List Link
        }
      }
    }
