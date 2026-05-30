-- CloudFront -> (ALB | S3) -> ECS -> (RDS | ElastiCache) — a typical
-- multi-tier web architecture, written with locally-composed helpers.
--
-- The library deliberately ships no "make a 3-tier VPC" abstractions; this
-- file shows how callers can build their own at the use-site instead.
let awsdac = ../package.dhall

let D = awsdac.Defaults

let AWS = awsdac.AWS.Types

let Svc = awsdac.AWS.Services

let P = awsdac.AWS.Presets

let Pos = awsdac.Position

let Dir = awsdac.Direction

let Align = awsdac.Align

let DF = awsdac.DefinitionFile

let entry = awsdac.Schema.entry

let hstack = awsdac.Layout.hstack

let arrow = awsdac.Link.arrow

-- ── own helpers ────────────────────────────────────────────────────────────
-- Compose the small primitives the library exposes into the shapes this
-- diagram actually needs.

let resource = \(t : Text) -> D.Resource::{ Type = t }

let publicSubnet =
      \(children : List Text) ->
        D.Resource::{
        , Type = AWS.EC2.Subnet
        , Preset = P.PublicSubnet
        , Children = children
        }

let privateSubnet =
      \(children : List Text) ->
        D.Resource::{
        , Type = AWS.EC2.Subnet
        , Preset = P.PrivateSubnet
        , Children = children
        }

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
                , Children = [ "EdgeStack", "VPC" ]
                }
            , entry "EdgeStack" (hstack [ "CloudFront", "StaticBucket" ])
            , entry "CloudFront" (resource Svc.CloudFront)
            , entry "StaticBucket" (resource AWS.S3.Bucket)
            , entry
                "VPC"
                D.Resource::{
                , Type = AWS.EC2.VPC
                , Direction = Dir.Vertical
                , Children =
                  [ "PublicStack", "ALB", "AppStack", "DataStack" ]
                }
            , entry "PublicStack" (hstack [ "PublicSubnet1", "PublicSubnet2" ])
            , entry "PublicSubnet1" (publicSubnet [ "NATGateway1" ])
            , entry "PublicSubnet2" (publicSubnet [ "NATGateway2" ])
            , entry "NATGateway1" (resource AWS.EC2.NatGateway)
            , entry "NATGateway2" (resource AWS.EC2.NatGateway)
            , entry
                "ALB"
                D.Resource::{
                , Type = AWS.ElasticLoadBalancingV2.LoadBalancer
                , Preset = P.ApplicationLoadBalancer
                }
            , entry "AppStack" (hstack [ "AppSubnet1", "AppSubnet2" ])
            , entry "AppSubnet1" (privateSubnet [ "ECSService1" ])
            , entry "AppSubnet2" (privateSubnet [ "ECSService2" ])
            , entry "ECSService1" (resource AWS.ECS.Service)
            , entry "ECSService2" (resource AWS.ECS.Service)
            , entry "DataStack" (hstack [ "DataSubnet1", "DataSubnet2" ])
            , entry "DataSubnet1" (privateSubnet [ "RDS1", "Cache1" ])
            , entry "DataSubnet2" (privateSubnet [ "RDS2", "Cache2" ])
            , entry "RDS1" (resource AWS.RDS.DBInstance)
            , entry "RDS2" (resource AWS.RDS.DBInstance)
            , entry "Cache1" (resource AWS.ElastiCache.CacheCluster)
            , entry "Cache2" (resource AWS.ElastiCache.CacheCluster)
            , entry
                "User"
                D.Resource::{
                , Type = AWS.Diagram.Resource
                , Preset = P.User
                }
            ]
          , Links =
            [ arrow "User" Pos.N "CloudFront" Pos.S
            , arrow "CloudFront" Pos.E "StaticBucket" Pos.W
            , arrow "CloudFront" Pos.SSW "ALB" Pos.N
            , arrow "ALB" Pos.SSW "ECSService1" Pos.NNE
            , arrow "ALB" Pos.SSE "ECSService2" Pos.NNW
            , arrow "ECSService1" Pos.SSW "RDS1" Pos.NNE
            , arrow "ECSService1" Pos.SSE "Cache1" Pos.NNW
            , arrow "ECSService2" Pos.SSW "RDS2" Pos.NNE
            , arrow "ECSService2" Pos.SSE "Cache2" Pos.NNW
            ]
          }
        }
