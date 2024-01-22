#!/bin/sh

if [ $# -eq 1 ]; then
	USERNAME="$1"
else
	USERNAME="$USER"
fi

HOME="/home/$USERNAME"

sudo xbps-install -S zsh tmux htop neovim neofetch

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

FILES=$(ls -A src)
CURRENT_DIR=$(pwd)

for FILE in $FILES; do
	if [ -d "$CURRENT_DIR/src/$FILE" ]; then
		if [ -d "$HOME/$FILE" ] && [ ! -L "$HOME/$FILE" ]; then
			echo "Merging contents of $FILE with existing directory in $HOME..."
			cp -r "$CURRENT_DIR/src/$FILE/." "$HOME/$FILE"
		else
			echo "Creating symlink for $FILE..."
			ln -sf "$CURRENT_DIR/src/$FILE" "$HOME/$FILE"
		fi
	else
		echo "Creating/updating symlink for $FILE..."
		ln -sf "$CURRENT_DIR/src/$FILE" "$HOME/$FILE"
	fi
done

echo "Dotfiles installed!"
