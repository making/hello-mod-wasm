FROM ghcr.io/vmware-labs/httpd-mod-wasm:latest as modules

FROM httpd:2.4
COPY --from=modules /usr/lib/libwasm_runtime.so /usr/lib/
COPY --from=modules /usr/local/apache2/modules/mod_wasm.so  /usr/local/apache2/modules/
COPY ./httpd.conf /usr/local/apache2/conf/
COPY ./wasm_modules/ /usr/local/apache2/wasm_modules/
