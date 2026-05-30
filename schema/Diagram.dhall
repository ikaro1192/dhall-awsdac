let DefinitionFile = ./DefinitionFile.dhall

let Resource = ./Resource.dhall

let Link = ./Link.dhall

in  { Diagram :
        { DefinitionFiles : List DefinitionFile
        , Resources : List { mapKey : Text, mapValue : Resource }
        , Links : List Link
        }
    }
