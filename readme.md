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

```

### Set config

Set the `kubectl` context:

```shell
$ cd some/folder
$ ctx view
No local context.
$ ctx set kubectl context foo
Setting ["kubectl", "context"] to value foo
$ctx view
{
  "kubectl": {
    "context": "foo"
  }
}
```

Set the `gcloud` preset. 

```shell
# You'll need to save the presets you want to a separate gcloud config
# e.g:

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
$ kc config view | grep current-context
current-context: my-dev
$ cd some/folder
$ kc config view | grep current-context
```

