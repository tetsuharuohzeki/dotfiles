#----------------------------------------------------------
# Global Settings
#

# rust
export RUST_BACKTRACE=full
# https://doc.rust-lang.org/cargo/guide/cargo-home.html
export CARGO_HOME=$HOME/.cargo

# Go
export GOPATH=$HOME/src/go

# sccache
#export RUSTC_WRAPPER=sccache
export SCCACHE_CACHE_SIZE="20G"
