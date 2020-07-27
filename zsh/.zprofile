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
        () {
        }
        ;;
esac

() {
    # nodebrew: https://github.com/hokaccha/nodebrew
    local NODEBREW_PATH=$HOME/.nodebrew/current/bin
    export PATH=$NODEBREW_PATH:$PATH

    # Android SDK
    # ANDROID_SDK_PATH=$HOME/appconfig/android-sdk
    # ADB_PATH=$ANDROID_SDK_PATH/platform-tools
    # export PATH=$ADB_PATH:$PATH
}

export PATH=$CARGO_HOME/bin:$PATH

# Go
export PATH=$GOPATH/bin:$PATH
