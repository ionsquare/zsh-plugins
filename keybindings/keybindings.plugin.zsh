# ===== Key Bindings ===========================================================
bindkey "^[[1;5C" forward-word      # Ctrl ->
bindkey "^[[1;5D" backward-word     # Ctrl <-
bindkey \^U backward-kill-line      # ^u
bindkey '[1~' beginning-of-line   # home
bindkey '[4~' end-of-line         # end

# ===== Shell forward/backward functionality (ctrl+shift+arrow) ================
shell-backward-word() {
	emulate -L zsh
	local words word spaces
	words=(${(z)LBUFFER})
	word=$words[-1]
	spaces=-1
	while [[ $LBUFFER[$spaces] == " " ]]; do
			(( spaces-- ))
	done
	(( CURSOR -= $#word - $spaces - 1 ))
}
bindkey "[1;6D" shell-backward-word   # Ctrl + Shift + <-
zle -N shell-backward-word

shell-forward-word() {
	emulate -L zsh
	local words word spaces
	words=(${(z)RBUFFER})
	word=$words[1]
	spaces=1
	while [[ $RBUFFER[$spaces] == " " ]]; do
		(( spaces++ ))
	done
	(( CURSOR += $#word + $spaces - 1 ))
}
bindkey "[1;6C" shell-forward-word   # Ctrl + Shift + ->
zle -N shell-forward-word

