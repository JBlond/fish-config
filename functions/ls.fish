# Defined in - @ line 1
function ls --description 'alias ls=ls --color=auto --group-directories-first'
	command ls --color=auto --group-directories-first $argv;
end
