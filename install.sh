#!/bin/sh

FILES=".zshrc .xinitrc .config photos"
CURRENT_DIR=$(pwd)

for FILE in $FILES; do
	if [ -d "$CURRENT_DIR/$FILE" ]; then
		if [ -d "$HOME/$FILE" ] && [ ! -L "$HOME/$FILE" ]; then
			echo "Merging contents of $FILE with existing directory in $HOME..."
			cp -r "$CURRENT_DIR/$FILE/." "$HOME/$FILE"
		else
			echo "Creating symlink for $FILE..."
			ln -sf "$CURRENT_DIR/$FILE" "$HOME/$FILE"
		fi
	else
		echo "Creating/updating symlink for $FILE..."
		ln -sf "$CURRENT_DIR/$FILE" "$HOME/$FILE"
	fi
done

echo "Dotfiles installed!"
