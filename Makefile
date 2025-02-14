RUSTV=stable

install_windows_on_mac:
	rustup target add x86_64-pc-windows-gnu
	brew install mingw-w64


build-windows:
	cargo build --target=x86_64-pc-windows-gnu


test-all:	test-unit test-derive test-examples

test-unit:
	cargo test --lib --all-features

test-examples:
	make -C examples test

test-derive:
	cd nj-derive; RUST_LOG=debug cargo test -- --nocapture


#
#  Various Lint tools
#

install-fmt:
	rustup component add rustfmt --toolchain $(RUSTV)

check-fmt:
	cargo +$(RUSTV) fmt -- --check

install-clippy:
	rustup component add clippy --toolchain $(RUSTV)

check-clippy:	install-clippy
	cargo +$(RUSTV) clippy --all --all-targets --all-features -- \
		-D warnings \
		-A clippy::upper_case_acronyms \
		-A clippy::needless-question-mark
