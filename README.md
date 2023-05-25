# Azure DevOps Build Agent

A containerised, Linux-hosted build agent for Azure DevOps running on Ubuntu 23.04.  The build agent in these images is of limited use since the image includes only a minimal runtime environment for the agent itself, including:

| Component | Version |
| -- | -- |
| git | 2.39.2 |
| nvm | 0.39.5 |
| node | 18.18.0 |
| Azure Cli | |

Tagged images are provided for the following versions of the build agent:

* 2.170.1 (deprecated)
* 2.181.2 (deprecated)
* 2.190.0
* 3.225.0

The image tag corresponds to the agent version and host os; the full identifier for the 2.190.0 image is:

`deltics/azdevops-buildagent:2.190.0-ubuntu23.04`


## Intended Use

Although the image may be used to deploy a functioning build agent the pipelines it could usefully run would be very limited due to the absence of tooling beyond git, node and nvm.

The intended use is for these images to be used as the _base_ for further images, adding additional tools to support more useful pipelines.

## More Equipped Images

In addition to the agent images provided to use as the basis for your custom agent tooling, some ready-to-use images are provided with selected tooling already installed.

For additional information on more fully equipped agent images, refer to the documentation for those as follows:

| Tag | Short Tag | Overview |
| --- | --------- | -------- |
| [*&lt;agent-version&gt;*-wakatipu](README-wakatipu.md) | Comprehensive tooling (everything _and_ the kitchen sink) for building GoLang microservices in an enterprise context.<br/>"Wakatipu" is the largest lake in the Ota**GO** region of New Zealand.<br/>See readme for details of versions of tools installed.|

_NOTE: The links to documentation for the above image(s) are only functional when viewing this [README in the original source repo on GitHub](https://github.com/deltics/azdevops-buildagent)_.


## Installation

Pull the image from Docker hub using either the full or short tag if provided, as required.

Simples.


## Agent Capabilities

Agent **Capabilities** are published using any environment variables defined at startup.  This base image defines environment variables for:

| Capability | Aliases |
| ---------- | ------- |
| Git  | - |
| Nvm  | NodeVersionManager |
| Node | NodeJS |

The value of each identifies the version of the particular software so that a pipeline may express **Demands** in terms of availability of the software in general, or a specific version where necessary.

It is recommended that any images which build on this base image introduce additional, similar environment variables for any tools introduced in those images.

Refer to the documentation of alternate tagged images, as listed above, for details of additional capabilities they may introduce.


## Execution

The image executes the build agent at startup, registering with an Azure DevOps Collection Agent Pool.  The agent unregisters at shutdown.

As a result, information is required to be passed to the startup script for the build agent hosted inside the container.  This information is passed via environment variables on the command line as follows:

| Variable   | Required | Description |
| ---------- | --- | --- |
| AZP_URL    | Y | The base url for the collection hosting the pool in which the agent should register at startup |
| AZP_TOKEN  | Y | A PAT with "Agent Pools: Read & Manage" scope
| AZP_POOL   | N | The name of the agent pool in which the agent should register at startup.  If this is not specified then "Default" is assumed

Refer to the documentation of alternate tagged images, as listed above, for details of additional execution requirements they may introduce.