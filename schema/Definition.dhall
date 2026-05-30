let DefinitionIcon = ./DefinitionIcon.dhall

let DefinitionLabel = ./DefinitionLabel.dhall

let DefinitionFill = ./DefinitionFill.dhall

let DefinitionBorder = ./DefinitionBorder.dhall

let DefinitionDirectory = ./DefinitionDirectory.dhall

let DefinitionZipFile = ./DefinitionZipFile.dhall

let DefinitionCFn = ./DefinitionCFn.dhall

in  { Type : Text
    , Icon : Optional DefinitionIcon
    , Label : Optional DefinitionLabel
    , Fill : Optional DefinitionFill
    , Border : Optional DefinitionBorder
    , HeaderAlign : Text
    , Directory : DefinitionDirectory
    , ZipFile : DefinitionZipFile
    , CFn : DefinitionCFn
    }
