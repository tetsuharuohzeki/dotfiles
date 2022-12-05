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

            path=(
                ${HOMEBREW_PATH_ARM64}/bin(N-/)
                ${HOMEBREW_PATH_INTEL}/bin(N-/)
                ${PATH}
            )

            local HOMEBREW_PATH=${HOMEBREW_PATH_INTEL}
            if [[ ${CPUTYPE} = "arm64" ]]; then
                #alias brew_intel="arch -arch x86_64 ${HOMEBREW_PATH_INTEL}/bin/brew"
                alias brew_arm64="arch -arch arm64e ${HOMEBREW_PATH_ARM64}/bin/brew"
                HOMEBREW_PATH=${HOMEBREW_PATH_ARM64}
            fi

            # MacVim
            local MACVIM_PATH=/Applications/MacVim.app
            export PATH=$MACVIM_PATH/Contents/bin:$PATH

            # git jump
            export PATH=${HOMEBREW_PATH}/share/git-core/contrib/git-jump/:$PATH
        }
        ;;

    linux*)
        () {
        }
        ;;
esac

() {
    eval "$(fnm env)"

    # Android SDK
    # ANDROID_SDK_PATH=$HOME/appconfig/android-sdk
    # ADB_PATH=$ANDROID_SDK_PATH/platform-tools
    # export PATH=$ADB_PATH:$PATH
}

export PATH=$CARGO_HOME/bin:$PATH

# Go
export PATH=$GOPATH/bin:$PATH
