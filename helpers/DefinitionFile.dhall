let DefinitionFile = ../schema/DefinitionFile.dhall

let url
    : Text -> DefinitionFile
    = \(u : Text) ->
        { Type = "URL"
        , Url = Some u
        , LocalFile = None Text
        , Embed = None Text
        }

let localFile
    : Text -> DefinitionFile
    = \(p : Text) ->
        { Type = "LocalFile"
        , Url = None Text
        , LocalFile = Some p
        , Embed = None Text
        }

let embed
    : Text -> DefinitionFile
    = \(e : Text) ->
        { Type = "Embed"
        , Url = None Text
        , LocalFile = None Text
        , Embed = Some e
        }

let awsLightIcons
    : DefinitionFile
    = url
        "https://raw.githubusercontent.com/awslabs/diagram-as-code/main/definitions/definition-for-aws-icons-light.yaml"

in  { url, localFile, embed, awsLightIcons }
