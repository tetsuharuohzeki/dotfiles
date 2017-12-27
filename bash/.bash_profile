#----------------------------------------------------------
# PATH
#

# homebrew
HOMEBREW_PATH=/usr/local
export PATH=$HOMEBREW_PATH/bin:$PATH


# rust cargo
export CARGO_HOME=$HOME/.cargo
export PATH=$CARGO_HOME/bin:$PATH

# MacVim
MACVIM_PATH=/Applications/MacVim.app
export PATH=$MACVIM_PATH/Contents/bin:$PATH


# rustc
export RUST_BACKTRACE=1


# Go
export GOPATH=$HOME/src/go
export PATH=$GOPATH/bin:$PATH


# Load .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
