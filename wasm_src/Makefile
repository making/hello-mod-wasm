all: hello

hello: ../wasm_modules/hello.wasm

../wasm_modules/hello.wasm:
	cd hello && \
	cargo build --target wasm32-wasi --release && \
	mkdir -p ../../wasm_modules/ && \
	cp target/wasm32-wasi/release/hello.wasm ../../wasm_modules/

.PHONY: ../wasm_modules/hello.wasm

clean:
	rm -fr ../wasm_modules
	rm -fr hello/target 
