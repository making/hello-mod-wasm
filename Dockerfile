FROM ghcr.io/vmware-labs/httpd-mod-wasm:latest as modules

FROM rust:1.65 as builder
WORKDIR /workspace
RUN rustup target add wasm32-wasi
COPY ./wasm_src /workspace/wasm_src
RUN make -C /workspace/wasm_src

FROM httpd:2.4
COPY --from=modules /usr/lib/libwasm_runtime.so /usr/lib/
COPY --from=modules /usr/local/apache2/modules/mod_wasm.so  /usr/local/apache2/modules/
COPY ./httpd.conf /usr/local/apache2/conf/
COPY --from=builder /workspace/wasm_modules/ /usr/local/apache2/wasm_modules/
RUN chmod a+r /usr/local/apache2/conf/* /usr/local/apache2/wasm_modules/*