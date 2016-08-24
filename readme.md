# Context

Helper scripts to manage configuring state between:

- kubernetes (kubectl)
- gcloud
- docker
- pachyderm

## Install

1. Clone this repo someplace
2. Add this line to your `.profile`

```
source path/to/this/repo/context.sh
```

## Usage

Context uses a per-directory config file to setup your environment. This is done via a few commands:


### View config

```
# See the current config
$ ctx view
No local context.
# This folder doesn't have any context to setup
$ cd some/folder
$ ctx view
{
  "gcloud": {
    "config": "default"
  },
  "kubectl": {
    "context": "sean-dev"
  }
}
```

### Set config

Set the `kubectl` context:

```shell
$ cd some/folder
$ ctx view
No local context.
$ ctx set kubectl context foo
$ctx view
{
  "kubectl": {
    "context": "foo"
  }
}
```

Set the `gcloud` preset. [Click here](./doc/gcloud.md) for more info on how to create a gcloud preset or check which ones you have available.

```shell
$ ctx set gcloud config foo
$ ctx view 
{
  "gcloud": {
    "config": "foo"
  }
}
```

### Use config

To use your local `.ctx` automatically, you'll have to use the wrapper scripts for each of your tools.

e.g.

```
kubectl => kc
pachctl => pc
gcloud => gc
```

Here's a specific example:

```
# This happens implicitly when you enter the directory
# e.g.
$ ctx view
No local context
To get started refer to: https://github.com/sjezewski/context
$ kc config view | grep current-context
current-context: my-dev
$ cd some/folder
$ ctx view
{
  "kubectl": {
    "context": "sean-dev"
  }
}
$ kc config view | grep current-context
current-context: sean-dev
```

