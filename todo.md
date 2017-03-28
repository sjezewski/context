Todos

- make easy script to kill / restart portforwarding
    - there are many cases where it can fail (node eviction, net disc, etc)
    - its annoying to trakc down the pid, and re-issue the command
    - maybe wrap it in a script that checks exit code and re-issues?
    - Cases:
        - handle multiple local cluster configs? that doesn't really make any sense
        - test out killing existing thing / restarting


- make into a binary for easier install (prob golang)
- add support for 'saving' the current state (k8s) to a context file
    - e.g. `ctx save kubectl` ... which would make a copy of hte kubeconfig, put it in the local dir, and update the `.ctx` file
- make it easy to use portforwarding OR a static IP via ADDRESS
- add support for s3 credentials
    - this will make the gcloud abst cleaner too prob

