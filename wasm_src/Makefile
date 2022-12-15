all: hello

hello: ../wasm_modules/hello.wasm

../wasm_modules/hello.wasm:
	cd hello && \
	cargo build --target wasm32-wasi --release && \
	cp target/wasm32-wasi/release/hello.wasm ../../wasm_modules/

.PHONY: ../wasm_modules/hello.wasm

clean:
	rm -f ../wasm_modules/hello.wasm
	rm -fr hello/target 
