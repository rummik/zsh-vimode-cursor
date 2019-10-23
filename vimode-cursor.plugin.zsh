#!/bin/zsh
autoload -U add-zle-hook-widget

function @vimode-cursor::keymap-select {
	case :''${ZLE_STATE// /:}:$KEYMAP:; in
		(*:viopp:*|*:vicmd:*|*:visual:*)
			echo -ne "\e[1 q";; # block cursor
		(*:overwrite:*)
			echo -ne "\e[3 q";; # underscore
		(*|*:viins:*)
			echo -ne "\e[5 q";; # vertical bar
	esac
}

function @vimode-cursor::line-init {
	zle -K viins
	echo -ne "\e[5 q" # vertical bar
}

add-zle-hook-widget keymap-select @vimode-cursor::keymap-select
add-zle-hook-widget line-init @vimode-cursor::line-init
