# Background
This repo was created to expirment with running Reaper in Kuberetes in prepration for creating [reaper-operator](https://github.com/jsanda/reaper-operator). 

The image created from this repo is currently used by [reaper-operator](https://github.com/jsanda/reaper-operator).

Images will be tagged as `reaper-k8s:<reaper version>` where `<reaper version>` can be either a tag, e.g., 2.0, or a commit hash. A commit hash is primarily intended for building images with unreleased versions of Reaper.

Note that building the image requires a local clone of the [cassandra-reaper](https://github.com/thelastpickle/cassandra-reaper) repo. The repo directory can be overridden as follows:

`$ REAPER_REPO=/path/to/reaper/repo make build-image`
