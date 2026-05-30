{ Schema =
  { Diagram = ./schema/Diagram.dhall
  , Resource = ./schema/Resource.dhall
  , Link = ./schema/Link.dhall
  , DefinitionFile = ./schema/DefinitionFile.dhall
  , IconFill = ./schema/IconFill.dhall
  , Options = ./schema/Options.dhall
  , BorderChild = ./schema/BorderChild.dhall
  , ArrowHead = ./schema/ArrowHead.dhall
  , Label = ./schema/Label.dhall
  , Labels = ./schema/Labels.dhall
  }
, Defaults =
  { Diagram = ./defaults/Diagram.dhall
  , Resource = ./defaults/Resource.dhall
  , Link = ./defaults/Link.dhall
  , Label = ./defaults/Label.dhall
  }
, Position = ./types/Position.dhall
, Direction = ./types/Direction.dhall
, Align = ./types/Align.dhall
, HeaderAlign = ./types/HeaderAlign.dhall
, BorderType = ./types/BorderType.dhall
, LineStyle = ./types/LineStyle.dhall
, LinkType = ./types/LinkType.dhall
, ArrowHeadType = ./types/ArrowHeadType.dhall
, IconFillType = ./types/IconFillType.dhall
, Color = ./helpers/Color.dhall
, DefinitionFile = ./helpers/DefinitionFile.dhall
, Arrow = ./helpers/Arrow.dhall
, AWS =
  { Types = ./aws/Types.dhall
  , Presets = ./aws/Presets.dhall
  }
}
