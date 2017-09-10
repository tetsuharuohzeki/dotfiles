#----------------------------------------------------------
# PATH
#

# homebrew
HOMEBREW_PATH=/usr/local
export PATH=$HOMEBREW_PATH/bin:$PATH

# nodebrew: https://github.com/hokaccha/nodebrew
NODEBREW_PATH=$HOME/.nodebrew/current/bin
export PATH=$NODEBREW_PATH:$PATH


## Ruby & RubyGem
#RUBY_PATH=$HOMEBREW_PATH/opt/ruby
#export PATH=$PATH:$RUBY_PATH/bin
#
## Python
#export PYTHONPATH=$HOME/src/python-lib


# Android SDK
# ANDROID_SDK_PATH=$HOME/appconfig/android-sdk
# ADB_PATH=$ANDROID_SDK_PATH/platform-tools
# export PATH=$ADB_PATH:$PATH

# MacVim
MACVIM_PATH=/Applications/MacVim.app
export PATH=$MACVIM_PATH/Contents/bin:$PATH


# rust cargo
export CARGO_HOME=$HOME/.cargo
export PATH=$CARGO_HOME/bin:$PATH

# rustc
export RUST_BACKTRACE=full

# racer
# RUST_RACER_PATH=$HOME/src/rust/racer
# export PATH=$RUST_RACER_PATH/target/release:$PATH
# export RUST_SRC_PATH=$HOME/src/rust/rustc/src
# export RUST_SRC_PATH=$HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src

# rls
# export DYLD_LIBRARY_PATH=$HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/lib

#rustfmt
# RUST_FMT_PATH=$HOME/src/rust/rustfmt
# export PATH=$RUST_FMT_PATH/target/release:$PATH


# for servo build
#export OPENSSL_INCLUDE_DIR="$(brew --prefix openssl)/include"
#export OPENSSL_LIB_DIR="$(brew --prefix openssl)/lib"


# Go
export GOPATH=$HOME/src/go
export PATH=$GOPATH/bin:$PATH


# Load .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
