let Resource = ../schema/Resource.dhall

let DResource = ../defaults/Resource.dhall

let Types = ../aws/Types.dhall

let hstack
    : List Text -> Resource
    = \(children : List Text) ->
        DResource::{
        , Type = Types.Diagram.HorizontalStack
        , Children = children
        }

let vstack
    : List Text -> Resource
    = \(children : List Text) ->
        DResource::{
        , Type = Types.Diagram.VerticalStack
        , Children = children
        }

in  { hstack, vstack }
