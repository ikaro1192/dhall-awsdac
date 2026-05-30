# dhall-awsdac

A Dhall library for [awsdac (aws-samples/diagram-as-code)](https://github.com/awslabs/diagram-as-code). Describe AWS architecture diagrams in type-safe Dhall, convert to awsdac-compatible YAML with `dhall-to-yaml`, then render to PNG with the `awsdac` CLI.

```
diagram.dhall ──dhall-to-yaml──► diagram.yaml ──awsdac──► diagram.png
```

See [spec.md](./spec.md) for design rationale and the awsdac internals this library relies on.

---

## Requirements

| Tool | Purpose | Notes |
|---|---|---|
| `dhall` | Type-checking and hashing | `brew install dhall` |
| `dhall-to-yaml` *or* `dhall-to-yaml-ng` | YAML conversion | `brew install dhall-yaml` (provides `dhall-to-yaml-ng`) |
| `awsdac` | Render YAML to PNG | **submodule HEAD is recommended** — `TitleFillColor`, `SpanResources`, etc. landed after the 0.23 release |

Build `awsdac` from the vendored submodule:

```bash
cd diagram-as-code && go build -o /usr/local/bin/awsdac ./cmd/awsdac
```

---

## Quick start

```dhall
-- diagram.dhall
let awsdac = ./package.dhall

let D   = awsdac.Defaults
let AWS = awsdac.AWS.Types
let P   = awsdac.AWS.Presets
let Dir = awsdac.Direction
let DF  = awsdac.DefinitionFile

let entry =
      \(n : Text) -> \(r : awsdac.Schema.Resource) ->
        { mapKey = n, mapValue = r }

in    D.Diagram
    ::  { Diagram =
          { DefinitionFiles = [ DF.awsLightIcons ]
          , Resources =
            [ entry "Canvas" D.Resource::{
              , Type = AWS.Diagram.Canvas
              , Direction = Dir.Vertical
              , Children = [ "VPC" ]
              }
            , entry "VPC" D.Resource::{
              , Type = AWS.EC2.VPC
              , Preset = P.AWSCloudNoLogo
              }
            ]
          , Links = [] : List awsdac.Schema.Link
          }
        }
```

```bash
dhall-to-yaml --omit-empty --file diagram.dhall > diagram.yaml
awsdac diagram.yaml -o diagram.png
```

Full examples: [`examples/alb-ec2.dhall`](./examples/alb-ec2.dhall), [`examples/vpc-natgw.dhall`](./examples/vpc-natgw.dhall).

---

## URL import

Once published, pin via SHA256:

```dhall
let awsdac =
      https://raw.githubusercontent.com/<owner>/dhall-awsdac/<tag>/package.dhall
        sha256:<hash>
```

Current hash:

```bash
$ dhall hash --file package.dhall
sha256:b38b2499b45c72e7c0b261d2131a36c7522a128496253081cd293356ff9cb142
```

> Expect breaking changes during the v0.x series.

---

## Layout

| Directory | Contents |
|---|---|
| [`schema/`](./schema) | Dhall types in 1:1 correspondence with the awsdac YAML schema |
| [`defaults/`](./defaults) | Default records for the `::` operator — write only the required fields |
| [`types/`](./types) | Text constants for Position / Direction / Align / etc. |
| [`helpers/`](./helpers) | `Color.rgba` builders, `DefinitionFile` variant constructors, `Arrow` presets |
| [`aws/`](./aws) | `AWS::*` resource-type constants (~30 curated) and preset names |
| [`examples/`](./examples) | Sample diagrams |
| [`test/`](./test) | Round-trip tests |
| [`package.dhall`](./package.dhall) | Public API entry point |

---

## API surface

```dhall
let awsdac = ./package.dhall

awsdac.Schema.{Diagram, Resource, Link, ...}     -- types
awsdac.Defaults.{Diagram, Resource, Link, Label} -- :: defaults
awsdac.{Position, Direction, Align, HeaderAlign, BorderType, LineStyle, LinkType, ArrowHeadType, IconFillType}
awsdac.Color.{rgba, rgb, transparent, black, white}
awsdac.DefinitionFile.{url, localFile, embed, awsLightIcons}
awsdac.Arrow.{open, default}
awsdac.AWS.Types.{Diagram, EC2, ELB, AutoScaling, RDS, Lambda, S3, IAM, DynamoDB, SQS, SNS, CloudFront, Route53, APIGateway, CloudWatch, KMS, ECS, EKS}
awsdac.AWS.Presets.{AWSCloudNoLogo, PublicSubnet, PrivateSubnet, ApplicationLoadBalancer, NetworkLoadBalancer, User, BlankGroup, Empty}
```

---

## Tests

Verifies that each Dhall example produces a **byte-identical PNG** to the upstream YAML sample:

```bash
bash test/render.sh
# Override the awsdac binary with $AWSDAC (defaults to the one on $PATH)
AWSDAC=/tmp/awsdac-head bash test/render.sh
```

`test/render.sh` performs:
1. `dhall type --file package.dhall` (schema type-check)
2. `dhall hash --file package.dhall` (prints the pinned SHA256)
3. For each example: render `dhall → yaml → png` and `upstream yaml → png`, compare with `cmp`

---

## v1 limitations

- AWS type constants are a curated subset (~30). For anything else, write the `"AWS::Foo::Bar"` string directly.
- `DefinitionFile.Embed` has a type slot but full `definition.DefinitionStructure` support is deferred to v2.
- No high-level abstractions like "create a VPC with public/private subnets" — users compose their own helpers.
- `Color.rgba` cannot enforce the 0–255 range at the Dhall type level; documented as a contract.
- Semantic awsdac constraints (e.g. Canvas must exist) are not expressible in Dhall and surface as awsdac runtime errors.
- `dhall-to-yaml` emits record fields in alphabetical order, so `Type` is not at the top of each resource. Functionally harmless, just less readable.

---

## License

Apache License 2.0. See [LICENSE](./LICENSE).
