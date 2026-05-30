{ Diagram =
  { Canvas = "AWS::Diagram::Canvas"
  , Cloud = "AWS::Diagram::Cloud"
  , Resource = "AWS::Diagram::Resource"
  , VerticalStack = "AWS::Diagram::VerticalStack"
  , HorizontalStack = "AWS::Diagram::HorizontalStack"
  }
, EC2 =
  { VPC = "AWS::EC2::VPC"
  , Subnet = "AWS::EC2::Subnet"
  , Instance = "AWS::EC2::Instance"
  , InternetGateway = "AWS::EC2::InternetGateway"
  , NatGateway = "AWS::EC2::NatGateway"
  , RouteTable = "AWS::EC2::RouteTable"
  , SecurityGroup = "AWS::EC2::SecurityGroup"
  , TransitGateway = "AWS::EC2::TransitGateway"
  }
, ELB =
  { LoadBalancer = "AWS::ElasticLoadBalancingV2::LoadBalancer"
  , TargetGroup = "AWS::ElasticLoadBalancingV2::TargetGroup"
  }
, AutoScaling = { AutoScalingGroup = "AWS::AutoScaling::AutoScalingGroup" }
, RDS =
  { DBInstance = "AWS::RDS::DBInstance"
  , DBCluster = "AWS::RDS::DBCluster"
  }
, Lambda = { Function = "AWS::Lambda::Function" }
, S3 = { Bucket = "AWS::S3::Bucket" }
, IAM =
  { Role = "AWS::IAM::Role"
  , User = "AWS::IAM::User"
  , Policy = "AWS::IAM::Policy"
  }
, DynamoDB = { Table = "AWS::DynamoDB::Table" }
, SQS = { Queue = "AWS::SQS::Queue" }
, SNS = { Topic = "AWS::SNS::Topic" }
, CloudFront = { Distribution = "AWS::CloudFront::Distribution" }
, Route53 = { HostedZone = "AWS::Route53::HostedZone" }
, APIGateway = { RestApi = "AWS::APIGateway::RestApi" }
, CloudWatch = { Alarm = "AWS::CloudWatch::Alarm" }
, KMS = { Key = "AWS::KMS::Key" }
, ECS =
  { Cluster = "AWS::ECS::Cluster"
  , Service = "AWS::ECS::Service"
  }
, EKS = { Cluster = "AWS::EKS::Cluster" }
}
