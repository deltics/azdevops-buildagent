# Azure DevOps Build Agent

A containerised, Linux-hosted build agent for Azure DevOps.

The build agent in these containers is of limited use since the image includes only a minimal runtime environment for the agent itself, including:

* Ubuntu 21.04 (base image)
* Git 2.30.2
* NVM 0.38
* Node 16.6.2
* Azure Cli

Tagged images are provided for the following versions of the build agent:

* 2.170.1
* 2.190.0 (latest)

The image tag corresponds to the agent version, so the full identifier for the 2.190.0 image is:

`deltics/azdevops-buildagent:2.190.0`

Multiple agent versions are provided so that auto-downgrade behaviour may be avoided by using images based on an appropriate build agent version, if that is an issue in your environment.


## Intended Use

Although the image may be used to deploy a functioning build agent, the pipelines it could usefully run would be very limited.  The intended use is for these images to be used as base images, adding additional tools to support more useful pipelines.

For additional information on more fully equipped agent images, refer to the documentation for those as follows:

| Tag | Short Tag | Overview |
| --- | --------- | -------- |
| [*&lt;agent-version&gt;*-docker20.10.8-dotnet5.0-gitversion5.6.6-go1.16.7-helm3.6.3-jdk11-jfrog2-maven3.8.2](README-wakatipu.md) | [&lt;agent-version&gt;-wakatipu](README-wakatipu.md) | Comprehensive tooling for building GoLang microservices in an enterprise context |

_NOTE: The links to documentation for the above image(s) are only functional when viewing this [README in the original source repo on GitHub](https://github.com/deltics/azdevops-buildagent/blob/master/README.md)_.


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
| AZP_TOKEN  | Y| A PAT with "Agent Pools: Read & Manage" scope
| AZP_POOL   | N | The name of the agent pool in which the agent should register at startup.  If this is not specified then "Default" is assumed

Refer to the documentation of alternate tagged images, as listed above, for details of additional execution requirements they may introduce.