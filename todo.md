Todos

- make kubectl use a specific file / context
- update pachctl to use ADDRESS (and get the IP from kubectl)
- consider using a global lock
    - while we don't strictly need a global lock if always using the ADDRESS,kubeconfig flags for pc/kc
    - if wrapping every command adds a few seconds ... this would be a way to make this faster
    - (I was seeing a few second time to wrap before ... can't remember what command was doing that ...)
        - i think maybe it was an 'init' command ... still don't quite remember though
        - ah, its in test/a --- on GKE I was running dm and needed to run a dm portforwarding command each time
    - the global lock would include a value that is the CWD w the lock
    - if that doesn't match the PWD then we can prompt to acquire the lock
- add support for 'saving' the current state (k8s) to a context file
- add support for s3 credentials
    - this will make the gcloud abst cleaner too prob
- make into a binary for easier install (prob golang)
