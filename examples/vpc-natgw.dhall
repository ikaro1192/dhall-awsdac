let awsdac = ../package.dhall

let D = awsdac.Defaults

let AWS = awsdac.AWS.Types

let P = awsdac.AWS.Presets

let Dir = awsdac.Direction

let Align = awsdac.Align

let DF = awsdac.DefinitionFile

let entry = awsdac.Schema.entry

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
                , Children =
                  [ "VPCPublicSubnetStack", "VPCPrivateSubnetStack" ]
                }
            , entry
                "VPCPublicSubnetStack"
                D.Resource::{
                , Type = AWS.Diagram.HorizontalStack
                , Children = [ "VPCPublicSubnet1", "VPCPublicSubnet2" ]
                }
            , entry
                "VPCPublicSubnet1"
                D.Resource::{
                , Type = AWS.EC2.Subnet
                , Preset = P.PublicSubnet
                , Children = [ "VPCPublicSubnet1NatGateway" ]
                }
            , entry
                "VPCPublicSubnet1NatGateway"
                D.Resource::{ Type = AWS.EC2.NatGateway }
            , entry
                "VPCPublicSubnet2"
                D.Resource::{
                , Type = AWS.EC2.Subnet
                , Preset = P.PublicSubnet
                , Children = [ "VPCPublicSubnet2NatGateway" ]
                }
            , entry
                "VPCPublicSubnet2NatGateway"
                D.Resource::{ Type = AWS.EC2.NatGateway }
            , entry
                "VPCPrivateSubnetStack"
                D.Resource::{
                , Type = AWS.Diagram.HorizontalStack
                , Children = [ "VPCPrivateSubnet1", "VPCPrivateSubnet2" ]
                }
            , entry
                "VPCPrivateSubnet1"
                D.Resource::{
                , Type = AWS.EC2.Subnet
                , Preset = P.PrivateSubnet
                , Children = [ "VPCPrivateSubnet1Instance" ]
                }
            , entry
                "VPCPrivateSubnet1Instance"
                D.Resource::{ Type = AWS.EC2.Instance }
            , entry
                "VPCPrivateSubnet2"
                D.Resource::{
                , Type = AWS.EC2.Subnet
                , Preset = P.PrivateSubnet
                , Children = [ "VPCPrivateSubnet2Instance" ]
                }
            , entry
                "VPCPrivateSubnet2Instance"
                D.Resource::{ Type = AWS.EC2.Instance }
            , entry
                "User"
                D.Resource::{
                , Type = AWS.Diagram.Resource
                , Preset = P.User
                }
            ]
          , Links = [] : List awsdac.Schema.Link
          }
        }
