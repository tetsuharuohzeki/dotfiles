#----------------------------------------------------------
# PATH
#

case ${OSTYPE} in
    darwin*)
        () {
            # homebrew
            local HOMEBREW_PATH='/usr/local'
            export PATH=$HOMEBREW_PATH/bin:$PATH

            # MacVim
            local MACVIM_PATH=/Applications/MacVim.app
            export PATH=$MACVIM_PATH/Contents/bin:$PATH
        }
        ;;

    linux*)
        ;;
esac

() {
    # nodebrew: https://github.com/hokaccha/nodebrew
    local NODEBREW_PATH=$HOME/.nodebrew/current/bin
    export PATH=$NODEBREW_PATH:$PATH
}

# Android SDK
# ANDROID_SDK_PATH=$HOME/appconfig/android-sdk
# ADB_PATH=$ANDROID_SDK_PATH/platform-tools
# export PATH=$ADB_PATH:$PATH

# rust cargo
export CARGO_HOME=$HOME/.cargo
export PATH=$CARGO_HOME/bin:$PATH

# rustc
export RUST_BACKTRACE=full

# for servo build
#export OPENSSL_INCLUDE_DIR="$(brew --prefix openssl)/include"
#export OPENSSL_LIB_DIR="$(brew --prefix openssl)/lib"

# Go
export GOPATH=$HOME/src/go
export PATH=$GOPATH/bin:$PATH