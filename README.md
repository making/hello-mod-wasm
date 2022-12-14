# Hello mod_wasm

Check wasm modules

```
$ wasmtime wasm_modules/hello_wasm.wasm

Hello, Wasm! @stdout
Hello, Wasm! @stderr
```

Deploy to Tanzu Application Platform

```
tanzu apps workload apply hello-mod-wasm \
  --git-repo https://github.com/making/hello-mod-wasm\
  --git-branch main \
  --type web \
  --app hello-mod-wasm \
  --param dockerfile=Dockerfile \
  -n demo \
  -y
```

or

```
git clone https://github.com/making/hello-mod-wasm
GIT_REPO=ghcr.io/making
tanzu apps workload apply hello-mod-wasm \
  --local-path ./hello-mod-wasm \
  --source-image ${GIT_REPO}/hello-mod-wasm-source \
  --type web \
  --app hello-mod-wasm \
  --param dockerfile=Dockerfile \
  -n demo \
  -y
```


```
$ curl -k $(kubectl get ksvc -n demo hello-mod-wasm -ojsonpath='{.status.url}')/hello-wasm 
Hello, Wasm! @stdout
```

```
$ kubectl logs -l app.kubernetes.io/part-of=hello-mod-wasm,app.kubernetes.io/component=run -c workload -n demo

[Wed Dec 14 21:52:30.281526 2022] [mpm_event:notice] [pid 1:tid 140697608187200] AH00489: Apache/2.4.54 (Unix) configured -- resuming normal operations
[Wed Dec 14 21:52:30.281753 2022] [core:notice] [pid 1:tid 140697608187200] AH00094: Command line: 'httpd -D FOREGROUND'
Hello, Wasm! @stderr
127.0.0.1 - - [14/Dec/2022:21:52:31 +0000] "GET /hello-wasm HTTP/1.1" 200 21
```
