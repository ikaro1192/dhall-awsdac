let Link = ../schema/Link.dhall

let DLink = ../defaults/Link.dhall

let Arrow = ./Arrow.dhall

let link
    : Text -> Text -> Text -> Text -> Link
    = \(source : Text) ->
      \(sourcePosition : Text) ->
      \(target : Text) ->
      \(targetPosition : Text) ->
        DLink::{
        , Source = source
        , SourcePosition = sourcePosition
        , Target = target
        , TargetPosition = targetPosition
        }

let arrow
    : Text -> Text -> Text -> Text -> Link
    = \(source : Text) ->
      \(sourcePosition : Text) ->
      \(target : Text) ->
      \(targetPosition : Text) ->
        DLink::{
        , Source = source
        , SourcePosition = sourcePosition
        , Target = target
        , TargetPosition = targetPosition
        , TargetArrowHead = Arrow.open
        }

in  { link, arrow }
