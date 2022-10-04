# Azure DevOps Build Agent for Building GoLang MicroServices

This image adds tooling typically used for building GoLang microservices in an enterprise environment.

Short tag: `Wakatipu`, named for the largest lake in the Ota**go** region of New Zealand.

On top of the base layer, this layer adds:

| Component | Version | Notes |
| -- | -- | -- |
| Docker | 20.10.18 |
| DotNet | 6.0 |
| gcc | 11 |
| GitVersion | 5.10.3 |
| GoLang | 1.19.1 |
| GoSwagger | 0.30.3 |
| Helm | 3.10.0 |
| JDK | 11.0.12.7.1 |
| JFrog | 2 |
| kubectl | 1.22.15 |
| Maven | 3.8.6 |

Additional GoLang Utilities
| Utility | Version |
| -- | -- |
| gocover-cobertura| - | (not versioned) |
| go-junit-report | 0.9.1 |


## Intended Use

This image is primarily intended for running **GoLang** pipelines, using **GitVersion** for semantic versioning based on git branch and commit history (DotNet SDK is included solely to support the GitVersion tool).

**Docker** binaries are included to support the building of container images.  The layer is not configured to run "Docker in Docker".  It is expected that the image would be run with socket binding, with docker commands in the pipeline being bound to the docker daemon running on the host (to build, scan and push images, not to run them).  Additional volumes should be mounted as required to provide the docker dameon with access to build assets and artefacts as required.  (See: **Socket Binding** in the **Execution** section, below).

**Helm** is included for publishing Helm charts, commonly used in deployments of GoLang microservices.

The **Amazon Corretto JDK 11** is included in order to support SonarQube scanning, where this is used (an Azure DevOps extension).

**JFrog Cli** is included to support publication of artifacts to JFrog artifactory.


## Installation

Pull the image from Docker hub.  Simples.


## Agent Capabilities

Agent **Capabilities** are published using any environment variables defined at startup.  In addition to capabilities inherited from the base agent image, this layer defines further environment variables for:

| Capability  | Aliases |
| ----------- | ------- |
| Docker      | - |
| DotNet      | DotNetSdk, DotNetCore, DotNetCoreSdk, DotNetFramework, DotNetFrameworkSdk |
| Gcc         | GnuC |
| GoSwagger   | - |
| GitVersion  | - |
| Go          | GoLang |
| Helm        | - |
| Java        | JavaRuntimeEnvironment, Jdk, Jre |
| JFrogCli    | - |
| KubeCtl     | - |
| Maven       | Mvn |


Consistent with the convention in the base agent layer, the value for each identifies the version of the particular software so that a pipeline may express **Demands** in terms of availability of the software in general, or a specific version where necessary.


## Execution

The image inherits the startup script of the base layer; execution instructions are therefore the same as for the base agent layer itself.


### Socket Binding
The Docker binaries in this image are intended to be used to run docker commands on the agent **host**, using socket binding:

`docker start -v /var/run/docker.sock:/var/run/docker.sock ... `