# Hello mod_wasm


## (Optinal) Build and Run wasm modules locally

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup target add wasm32-wasi
```

```
make -C wasm_src
```

```
brew install wasmtime
wasmtime wasm_modules/hello.wasm
```

```
Hello, world!
```

## Build and Run with docker

```
docker build . -t hello-mod-wasm 
```

```
docker run --rm -e PORT=8080 -p 8080:8080 hello-mod-wasm
```

```
$ curl localhost:8080/hello
Hello, world!
```

## Build and Run with Tanzu Application Platform

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
$ curl -k $(kubectl get ksvc -n demo hello-mod-wasm -ojsonpath='{.status.url}')/hello
Hello, world!
```
