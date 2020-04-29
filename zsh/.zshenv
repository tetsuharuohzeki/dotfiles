#----------------------------------------------------------
# PATH
#

case ${OSTYPE} in
    darwin*)
        () {
            # macOS (at least ~10.14) has /etc/zprofile
            # and it excutes `/usr/libexec/path_helper` to add some dirs to the front of `$PATH`.
            # This settings disables to load global configurations
            unsetopt GLOBAL_RCS
            # setup default path items
            export PATH=''
            eval $(/usr/libexec/path_helper -s)

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

# Go
export GOPATH=$HOME/src/go
export PATH=$GOPATH/bin:$PATH