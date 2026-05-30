let Embed = ../schema/Embed.dhall

let Definition = ../schema/Definition.dhall

in  { Type = Embed
    , default =
      { Definitions = [] : List { mapKey : Text, mapValue : Definition } }
    }
