let DefinitionZipFile = ../schema/DefinitionZipFile.dhall

in  { Type = DefinitionZipFile
    , default = { SourceType = "", Source = "", Path = "", Url = "" }
    }
