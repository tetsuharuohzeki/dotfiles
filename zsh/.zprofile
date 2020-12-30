#----------------------------------------------------------
# PATH
#
# deduplicate items in path.
typeset -gU path PATH

case ${OSTYPE} in
    darwin*)
        () {
            # homebrew
            local HOMEBREW_PATH_INTEL='/usr/local'
            local HOMEBREW_PATH_ARM64='/opt/homebrew'
            #export PATH=${HOMEBREW_PATH_A64}/bin:$HOMEBREW_PATH_X64/bin:$PATH

            path=(
                ${HOMEBREW_PATH_ARM64}/bin(N-/)
                ${HOMEBREW_PATH_INTEL}/bin(N-/)
                ${PATH}
            )

            if [[ ${CPUTYPE} = "arm64" ]]; then
                alias brew_intel="arch -arch x86_64 ${HOMEBREW_PATH_INTEL}/bin/brew"
                alias brew_arm64="arch -arch arm64e ${HOMEBREW_PATH_ARM64}/bin/brew"
            fi

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
