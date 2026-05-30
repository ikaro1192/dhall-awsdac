let Label = ../schema/Label.dhall

in  { Type = Label
    , default =
      { Type = None Text
      , Color = None Text
      , Font = None Text
      }
    }
