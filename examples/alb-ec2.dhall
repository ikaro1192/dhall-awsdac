let awsdac = ../package.dhall

let D = awsdac.Defaults

let AWS = awsdac.AWS.Types

let P = awsdac.AWS.Presets

let Pos = awsdac.Position

let Dir = awsdac.Direction

let Align = awsdac.Align

let DF = awsdac.DefinitionFile

let Arrow = awsdac.Arrow

let IF = awsdac.IconFillType

let Resource = awsdac.Schema.Resource

let entry =
      \(n : Text) ->
      \(r : Resource) ->
        { mapKey = n, mapValue = r }

in    D.Diagram
    ::  { Diagram =
          { DefinitionFiles = [ DF.awsLightIcons ]
          , Resources =
            [ entry
                "Canvas"
                D.Resource::{
                , Type = AWS.Diagram.Canvas
                , Direction = Dir.Vertical
                , Children = [ "AWSCloud", "User" ]
                }
            , entry
                "AWSCloud"
                D.Resource::{
                , Type = AWS.Diagram.Cloud
                , Direction = Dir.Vertical
                , Preset = P.AWSCloudNoLogo
                , Align = Align.Center
                , Children = [ "VPC" ]
                }
            , entry
                "VPC"
                D.Resource::{
                , Type = AWS.EC2.VPC
                , Direction = Dir.Vertical
                , Children = [ "VPCPublicStack", "ALB" ]
                , BorderChildren = [ { Position = Pos.S, Resource = "IGW" } ]
                }
            , entry
                "VPCPublicStack"
                D.Resource::{
                , Type = AWS.Diagram.HorizontalStack
                , Children = [ "VPCPublicSubnet1", "VPCPublicSubnet2" ]
                }
            , entry
                "VPCPublicSubnet1"
                D.Resource::{
                , Type = AWS.EC2.Subnet
                , Preset = P.PublicSubnet
                , Children = [ "VPCPublicSubnet1Instance" ]
                }
            , entry
                "VPCPublicSubnet1Instance"
                D.Resource::{ Type = AWS.EC2.Instance }
            , entry
                "VPCPublicSubnet2"
                D.Resource::{
                , Type = AWS.EC2.Subnet
                , Preset = P.PublicSubnet
                , Children = [ "VPCPublicSubnet2Instance" ]
                }
            , entry
                "VPCPublicSubnet2Instance"
                D.Resource::{ Type = AWS.EC2.Instance }
            , entry
                "ALB"
                D.Resource::{
                , Type = AWS.ELB.LoadBalancer
                , Preset = P.ApplicationLoadBalancer
                }
            , entry
                "IGW"
                D.Resource::{
                , Type = AWS.EC2.InternetGateway
                , IconFill = Some { Type = Some IF.Rect, Color = None Text }
                }
            , entry
                "User"
                D.Resource::{
                , Type = AWS.Diagram.Resource
                , Preset = P.User
                }
            ]
          , Links =
            [ D.Link::{
              , Source = "ALB"
              , SourcePosition = Pos.NNW
              , Target = "VPCPublicSubnet1Instance"
              , TargetPosition = Pos.SSE
              , TargetArrowHead = Arrow.open
              }
            , D.Link::{
              , Source = "ALB"
              , SourcePosition = Pos.NNE
              , Target = "VPCPublicSubnet2Instance"
              , TargetPosition = Pos.SSW
              , TargetArrowHead = Arrow.open
              }
            , D.Link::{
              , Source = "IGW"
              , SourcePosition = Pos.N
              , Target = "ALB"
              , TargetPosition = Pos.S
              , TargetArrowHead = Arrow.open
              }
            , D.Link::{
              , Source = "User"
              , SourcePosition = Pos.N
              , Target = "IGW"
              , TargetPosition = Pos.S
              , TargetArrowHead = Arrow.open
              }
            ]
          }
        }
