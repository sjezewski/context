# Gcloud

To use a gcloud preset you first need to create one.

```shell
# You'll need to save the presets you want to a separate gcloud config
# To check what configurations you have:
$gcloud config configurations list
NAME      IS_ACTIVE  ACCOUNT                  PROJECT            DEFAULT_ZONE   DEFAULT_REGION
default   True       sean@place.com           sean-dev           us-central1-c  us-central1
foo       False      sean@gmail.com           sandbox            us-central1-c  us-central1
# To check which config is active, run:
$gcloud config list
Your active configuration is: [default]

[compute]
region = us-central1
zone = us-central1-c
[container]
cluster = foo 
[core]
account = sean@place.com
disable_usage_reporting = False
project = bar
# To create a new config, run:
$gcloud init
```
