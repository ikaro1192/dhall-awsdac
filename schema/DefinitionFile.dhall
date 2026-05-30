let Embed = ./Embed.dhall

in  { Type : Text
    , Url : Optional Text
    , LocalFile : Optional Text
    , Embed : Optional Embed
    }
