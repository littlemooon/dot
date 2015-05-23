DIR=$( cd "$( dirname "$0" )" && pwd )

echo '--- installing homebrew'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew doctor # if this fails run: export PATH="/usr/local/bin:$PATH"

echo '--- installing packages'
brew install node
brew install git
brew install tmux

echo '--- setting git keychain'
git config --global credential.helper osxkeychain

echo '--- downloading antigen'
curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > $DIR/zsh/antigen.zsh

echo '--- downloading fira code font'
curl -L https://github.com/tonsky/FiraCode/releases/download/0.3/FiraCode-Regular.otf > $DIR/FiraCode-Regular.otf

echo '--- installing vundle bundles'
git clone https://github.com/gmarik/Vundle.vim.git $DIR/vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo '--- setting zshenv'
cat <<EOM > $HOME/.zshenv
# don't load default zshrc
setopt no_global_rcs

# environmnet variables
export XDG_CONFIG_HOME="$HOME/.config"
# move zsh config to $XDG_CONFIG_HOME
export ZDOTDIR="\$XDG_CONFIG_HOME/zsh"
# move vim config to $XDG_CONFIG_HOME
export VIMINIT='let \$MYVIMRC="\$XDG_CONFIG_HOME/vim/.vimrc" | source \$MYVIMRC'
EOM

echo '--- set zsh as default:'
chsh -s /bin/zsh