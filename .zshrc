# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ouss/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [ -n "$DISPLAY" ] && [ -z "$TMUX" ]; then
  tmux attach || tmux new-session
fi


if [ -z "$DISPLAY" ]; then
  startx
fi
